# auxiliary/main.py
import boto3
from fastapi import FastAPI

VERSION = "auxiliary-1.0.0"

app = FastAPI()
s3 = boto3.client("s3", region_name="us-east-1")
ssm = boto3.client("ssm", region_name="us-east-1")

@app.get("/version")
def version():
    return {"version": VERSION}

@app.get("/buckets")
def get_buckets():
    response = s3.list_buckets()
    buckets = [b['Name'] for b in response.get('Buckets', [])]
    return {"version": VERSION, "buckets": buckets}

@app.get("/parameters")
def get_parameters():
    response = ssm.describe_parameters()
    params = [p['Name'] for p in response.get('Parameters', [])]
    return {"version": VERSION, "parameters": params}

