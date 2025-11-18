import pytest
from datetime import timedelta

# NOTE: sesuaikan import path sesuai struktur projek Anda. 
# Jika modul engine Anda bernama `game_economy`, ganti di bawah.
from game_economy import EconomyEngine, ConfigLoader

CONFIG_PATH = "config/config.game.json"

@pytest.fixture
def config():
    return ConfigLoader.load(CONFIG_PATH)

@pytest.fixture
def engine(config):
    e = EconomyEngine(config)
    e.set_random_seed(12345)
    return e

def test_corruption_never_exceeds_hardcap_after_policy(engine, config):
    HARDCAP = config['corruption']['hardcap']
    # Stress simulation
    for i in range(0, 5000):
        engine.inject_corruption(10000)
        engine.run_corruption_cycle()
        assert engine.get_corruption_total() <= HARDCAP, \
            f"Corruption exceeded hardcap: {engine.get_corruption_total()} > {HARDCAP}"

def test_market_floor_invariant_after_stabilizer(engine, config):
    # Force supply heavy scenario
    for commodity, meta in config['market']['commodities_sample'].items():
        engine.set_supply(commodity, 1000000)
        engine.set_demand(commodity, 100)
    engine.run_market_cycle()
    floor_mult = config['market']['stabilizer']['floor_multiplier']
    for commodity, meta in config['market']['commodities_sample'].items():
        retail = engine.get_retail_price(commodity)
        min_allowed = meta['hpp'] * floor_mult
        assert retail >= min_allowed, f"Retail price {retail} for {commodity} below floor {min_allowed}"

def test_stabilizer_budget_not_negative(engine, config):
    initial_reserve = engine.get_government_reserve()
    engine.run_market_cycle()
    assert engine.get_government_reserve() >= 0, "Government reserve went negative"

def test_full_economy_smoke(engine, config):
    for _ in range(0, 24):
        engine.run_corruption_cycle()
        engine.run_market_cycle()
    assert engine.get_corruption_total() <= config['corruption']['hardcap']
    assert engine.get_system_health() == "OK"
