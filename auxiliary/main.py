import boto3
from fastapi import FastAPI

app = FastAPI()
s3 = boto3.client("s3", region_name="us-east-1")
ssm = boto3.client("ssm", region_name="us-east-1")

@app.get("/buckets")
def get_buckets():
    response = s3.list_buckets()
    return {"version": "1.0.0", "buckets": [b['Name'] for b in response['Buckets']]}

@app.get("/parameters")
def get_parameters():
    response = ssm.describe_parameters()
    return {"version": "1.0.0", "parameters": [p['Name'] for p in response['Parameters']]}

