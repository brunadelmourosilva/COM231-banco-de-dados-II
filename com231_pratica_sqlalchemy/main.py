from sqlalchemy import *
from sqlalchemy.ext.automap import automap_base

def criamodelo():

    engine = create_engine("postgresql+psycopg2://postgres:root@localhost:5432/postgres", echo=False)

    # guarda modelo vindo do banco de dados
    base = automap_base()

    #mapeamento do schema do banco
    base.prepare(engine, schema="northwind", reflect=True)

    print(base.classes.keys())

if __name__ == '__main__':
    criamodelo()