import argparse
import json
import copy
import apache_beam as beam
from datetime import datetime
from apache_beam import pvalue
from apache_beam.options.pipeline_options import PipelineOptions, SetupOptions, StandardOptions


class ParseAndValidate(beam.DoFn):
    def __init__(self):
        self.required_fields = {"meter_id", "timestamp", "location", "voltage", "current", "consumption_kwh", "status"}
        self.valid_statuses = {"OK", "FAULT", "OFFLINE"}

    def process(self, element):
        errors = []
        raw_element = element.decode("utf-8")

        try:
            record = json.loads(raw_element)
        except Exception:
            yield pvalue.TaggedOutput('errors', {
                'error': 'invalid_json',
                'raw': raw_element
            })
            return

        # Check for missing fields
        missing_fields = self.required_fields - set(record.keys())
        if missing_fields:
            errors.append(f'missing_fields: {", ".join(missing_fields)}')

        # Type conversions and validation
        try:
            record['voltage'] = float(record['voltage'])
        except Exception:
            errors.append('invalid_voltage')

        try:
            record['current'] = float(record['current'])
        except Exception:
            errors.append('invalid_current')

        try:
            record['consumption_kwh'] = float(record['consumption_kwh'])
        except Exception:
            errors.append('invalid_consumption_kwh')

        try:
            record['timestamp'] = self.convert_to_timestamp(record['timestamp'])
        except Exception:
            errors.append(f'invalid_timestamp: {record.get("timestamp")}')

        # Status validation
        if record.get('status') not in self.valid_statuses:
            errors.append(f'invalid_status: {record.get("status")}')

        # If there are errors, yield each one separately
        if errors:
            error_record = copy.deepcopy(record)
            if isinstance(error_record.get('timestamp'), datetime):
                error_record['timestamp'] = error_record['timestamp'].isoformat()

            for error in errors:
                yield pvalue.TaggedOutput('errors', {
                    'error': error,
                    'raw': json.dumps(error_record)
                })
        else:
            yield record

    def convert_to_timestamp(self, timestamp_str):
        try:
            return datetime.fromisoformat(timestamp_str.replace("Z", "+00:00"))
        except ValueError:
            raise ValueError("Invalid timestamp format")

def run(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument('--project_id', help='GCP project ID')
    parser.add_argument('--dataset', default='measurements', help='BigQuery dataset name')
    parser.add_argument('--topic', default='smart_meter_topic', help='Pub/Sub topic name')

    args, pipeline_args = parser.parse_known_args(argv)
    pipeline_args.extend(["--project=" + args.project_id.strip()])

    pipeline_options = PipelineOptions(pipeline_args)
    pipeline_options.view_as(SetupOptions).save_main_session = True
    pipeline_options.view_as(StandardOptions).streaming = True

    project_id = args.project_id
    dataset = args.dataset
    topic = args.topic

    with beam.Pipeline(options=pipeline_options) as p:
        messages = p | 'ReadFromPubSub' >> beam.io.ReadFromPubSub(
            topic=f'projects/{project_id}/topics/{topic}'
        )

        parsed = (
            messages
            | 'ParseAndValidate' >> beam.ParDo(ParseAndValidate()).with_outputs('errors', main='valid')
        )

        parsed.valid | 'WriteValidToBigQuery' >> beam.io.WriteToBigQuery(
            f'{project_id}:{dataset}.smart_meter',
            schema=(
                'meter_id:STRING, '
                'timestamp:TIMESTAMP, '
                'location:STRING, '
                'voltage:FLOAT, '
                'current:FLOAT, '
                'consumption_kwh:FLOAT, '
                'status:STRING'
            ),
            write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND
        )

        parsed.errors | 'WriteErrorsToBigQuery' >> beam.io.WriteToBigQuery(
            f'{project_id}:{dataset}.errors',
            schema='error:STRING, raw:STRING',
            write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND
        )


if __name__ == '__main__':
    run()
