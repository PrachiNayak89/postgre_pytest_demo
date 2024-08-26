import pandas as pd


def get_drivers(db_url):
    """Return rows from the driver table."""
    sql = "SELECT * FROM car_schedule.drivers"
    results = pd.read_sql_query(sql=sql, con=db_url)
    if len(results) > 1:
        # Do logic here.
        pass
    return results