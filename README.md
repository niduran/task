### GCP Infrastructure Deployment with Terraform
This project provisions and configures various Google Cloud Platform (GCP) services using Terraform. The following resources are deployed:

Pub/Sub
Artifact Registry
BigQuery (with datasets and tables)
### Improvements:
Cloud Composer: Add Terraform configuration to deploy Cloud Composer and automate the upload of DAG files.

Cloud Build: Add a build pipeline for Artifact Registry to automate Docker image builds and pushes.

# Project Setup Notes:
You must update the project_id in all relevant Terraform and deployment scripts.

This project was tested using a free-tier GCP instance.

## Dataflow Template Build Commands
The following commands were used to build and deploy the Dataflow Flex Template:

# Build Docker image
<pre lang="markdown"> docker build -t europe-west1-docker.pkg.dev/forward-ellipse-459206-a5/dataflow-repo-nikolina/dataflow-pipeline:latest -f dataflow/Dockerfile dataflow </pre>

# Push Docker image to Artifact Registry
<pre lang="markdown"> docker push europe-west1-docker.pkg.dev/forward-ellipse-459206-a5/dataflow-repo-nikolina/dataflow-pipeline:latest </pre>

# Create Flex Template for Dataflow
<pre lang="markdown"> gcloud dataflow flex-template build gs://dataflow_bucket_test_1/template.json \
  --image=europe-west1-docker.pkg.dev/forward-ellipse-459206-a5/dataflow-repo-nikolina/dataflow-pipeline:latest \
  --sdk-language=PYTHON \
  --metadata-file=dataflow/template_spec/metadata.json </pre>
# BigQuery View Creation
The following SQL creates a unified view combining records with and without errors:  


<pre lang="markdown"> CREATE OR REPLACE VIEW `forward-ellipse-459206-a5.measurements.smart_meter_with_errors` AS
SELECT
  ARRAY_AGG(error) AS errors,
  JSON_VALUE(raw, '$.meter_id') AS meter_id,
  TIMESTAMP(JSON_VALUE(raw, '$.timestamp')) AS timestamp,
  JSON_VALUE(raw, '$.location') AS location,
  SAFE_CAST(JSON_VALUE(raw, '$.voltage') AS FLOAT64) AS voltage,
  SAFE_CAST(JSON_VALUE(raw, '$.current') AS FLOAT64) AS current,
  SAFE_CAST(JSON_VALUE(raw, '$.consumption_kwh') AS FLOAT64) AS consumption_kwh,
  JSON_VALUE(raw, '$.status') AS status
FROM
  `forward-ellipse-459206-a5.measurements.errors`
GROUP BY raw

UNION ALL

SELECT
  [] AS errors,
  meter_id,
  timestamp,
  location,
  voltage,
  current,
  consumption_kwh,
  status
FROM
  `forward-ellipse-459206-a5.measurements.smart_meter`  </pre>

# Looker Studio
Link on dashboard for quality
https://lookerstudio.google.com/s/sqHtmoH6dLE
