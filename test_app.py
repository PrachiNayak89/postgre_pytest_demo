import pytest
from app import get_drivers
import logging

logging.basicConfig()
logger = logging.getLogger()
logger.setLevel(logging.DEBUG)


@pytest.fixture()
def database(postgresql):
    """Set up the mock DB with the SQL flat file."""
    with open("test.sql") as f:
        setup_sql = f.read()
    with postgresql.cursor() as cursor:
        cursor.execute(setup_sql)
        postgresql.commit()
    logger.info("yielding the cursor against the test postgres db.")
    yield postgresql


def test_example_postgres(database):
    drivers = get_drivers(db_url=database)
    assert len(drivers) == 2
    assert set(drivers["name"]) == {"Dan", "Jeff"}
    logger.info("Tests passed")