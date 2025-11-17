from airflow import DAG
from datetime import datetime
from airflow.providers.standard.operators.python import PythonOperator  # versão nova do Airflow 3.x
import pandas as pd
import requests

def extract_data():
    """Captura dados da API e retorna como lista de dicionários."""
    url = "https://data.cityofnewyork.us/resource/rc75-m7u3.json"
    response = requests.get(url)
    df = pd.DataFrame(response.json())
    return df.to_dict(orient='records')

def load_data(ti):
    """Salva os dados capturados em um arquivo CSV."""
    dados = ti.xcom_pull(task_ids='captura_conta_dados')
    if not dados:
        print("Nenhum dado retornado, arquivo não criado.")
        return
    df = pd.DataFrame(dados)
    caminho = '/opt/airflow/data/file.csv' 
    df.to_csv(caminho, index=False)
    print(f"Arquivo salvo com sucesso em: {caminho}")

with DAG(
    dag_id='minha_dag_xlp67',
    start_date=datetime(2025, 11, 12),
    schedule='30 * * * *',  
    catchup=False
) as dag:
    
    captura_conta_dados = PythonOperator(
        task_id='captura_conta_dados',
        python_callable=extract_data
    )

    write_file = PythonOperator(
        task_id='write_file',
        python_callable=load_data
    )

    captura_conta_dados >> write_file
