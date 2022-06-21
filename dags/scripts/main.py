import requests
import pandas as pd
import mysql.connector
from sqlalchemy import create_engine
import psycopg2 as pg

def fetch_api(url):
    r = requests.get(url)
    res = pd.DataFrame(r.json()['data']['content'])
    res.columns = map(str.lower, res.columns)

    return res
    
def to_stg(res):
    engine = create_engine('mysql+mysqlconnector://user:password@198.74.101.36:3306/db', echo=False)
    res.to_sql(name='stg_covid_data', con=engine, if_exists = 'replace', index=False)

def to_dwh():
    engine1 = create_engine('mysql+mysqlconnector://user:password@198.74.101.36:3306/db', echo=False)
    pg_engine = create_engine('postgresql+psycopg2://indra:indra@147.139.209.176/covid_dwh')
    load_stg = pd.read_sql('select * from stg_covid_data', engine1)
    load_stg.to_sql(name='stg_covid_data', con=pg_engine, if_exists ='replace', index=False,method='multi')

def main(url):
    res = fetch_api(url)
    to_stg(res)
    to_dwh()

if __name__ == '__main__':
    main()