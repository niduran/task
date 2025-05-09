from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.operators.dataflow import DataflowTemplatedJobStartOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator

def delete_old_data():
    sql_query = """
    DELETE FROM `forward-ellipse-459206-a5.measurements.errors`
    WHERE timestamp < TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
    """
    return sql_query

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    'start_date': datetime(2025, 5, 8),
}

with DAG(
    'data_validation_and_cleanup',
    default_args=default_args,
    description='daily validation and deletion stale data in BigQuery',
    schedule_interval='@daily', 
    catchup=False,
) as dag:

    validate_dataflow_task = DataflowTemplatedJobStartOperator(
        task_id="start_template_job",
        project_id="orward-ellipse-459206-a5",
        template='gs://dataflow_bucket_test_1/template.json',
        parameters={
            'project-id': 'forward-ellipse-459206-a5',
            'dataset': 'measurements',
            'topic': 'smart_meter_topic'
        },
        location='europe-west1',  
        wait_until_finished=True,  
    )

    delete_old_data_task = BigQueryInsertJobOperator(
        task_id='delete_old_data',
        configuration={
        "query": {
            "query": delete_old_data(),
            "useLegacySql": False,
        }}
    )

    validate_dataflow_task >> delete_old_data_task 
