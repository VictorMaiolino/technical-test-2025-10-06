import json
import os
import boto3
from datetime import datetime, timezone

sns = boto3.client("sns")
TOPIC_ARN = os.getenv("TOPIC_ARN", "")

def _log(level, message, **kwargs):
    # Log JSON estruturado (útil para CloudWatch Logs Insights)
    print(json.dumps({
        "ts": datetime.now(timezone.utc).isoformat(),
        "level": level,
        "message": message,
        **kwargs
    }))

def handler(event, context):
    _log("INFO", "event_received", raw_event=event)
    try:
        record = event["Records"][0]
        s3 = record["s3"]
        bucket = s3["bucket"]["name"]
        key = s3["object"]["key"]
        size = s3["object"].get("size")
        etag = s3["object"].get("eTag")
        event_name = record.get("eventName")
        region = record.get("awsRegion")

        payload = {
            "event": "s3_object_created",
            "bucket": bucket,
            "key": key,
            "size": size,
            "etag": etag,
            "eventName": event_name,
            "region": region,
            "receivedAt": datetime.now(timezone.utc).isoformat()
        }

        _log("INFO", "publishing_to_sns", topic=TOPIC_ARN, payload=payload)

        if TOPIC_ARN:
            sns.publish(
                TopicArn=TOPIC_ARN,
                Subject="S3 Object Created",
                Message=json.dumps(payload),
                MessageAttributes={
                    "bucket": {"DataType": "String", "StringValue": bucket},
                    "region": {"DataType": "String", "StringValue": region or "unknown"}
                }
            )
        else:
            _log("WARN", "missing_topic_arn_env")

        _log("INFO", "done")
        return {"statusCode": 200, "body": json.dumps({"ok": True})}

    except Exception as e:
        _log("ERROR", "handler_exception", error=str(e))
        raise
