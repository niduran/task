import json
import time
import os
from google.cloud import pubsub_v1

project_id = "forward-ellipse-459206-a5"
topic_id = "smart_meter_topic"
file_path = "generating_data/smart_meter_sample_data.json"

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(project_id, topic_id)

try:
    publisher.create_topic(request={"name": topic_path})
    print(f"Topic created: {topic_path}")
except Exception as e:
    print(f"Topic probably already exists: {e}")


with open(file_path, 'r') as file:
    for line in file:
        try:
            data = json.loads(line)
            message = json.dumps(data).encode("utf-8")
            future = publisher.publish(topic_path, message)
            print(f"Published: {message}")
            time.sleep(1) 
        except json.JSONDecodeError as e:
            print(f"Failed to parse line: {line} -> {e}")
