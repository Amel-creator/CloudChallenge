# api/main.py
import os
import requests
import boto3
from fastapi import FastAPI

VERSION = "main-api-1.0.0"
AUX_URL = os.getenv("AUX_URL", "http://auxiliary-svc.auxiliary.svc.cluster.local:8082")

app = FastAPI()
s3 = boto3.client("s3", region_name="us-east-1")
ssm = boto3.client("ssm", region_name="us-east-1")

def get_aux_version():
    try:
        r = requests.get(f"{AUX_URL}/version", timeout=2)
        r.raise_for_status()
        return r.json().get("version")
    except Exception:
        return None

@app.get("/version")
def version():
    aux_ver = get_aux_version()
    return {"api_version": VERSION, "aux_version": aux_ver}

@app.get("/list-buckets")
def list_buckets():
    resp = s3.list_buckets()
    return {"api_version": VERSION, "buckets": [b["Name"] for b in resp.get("Buckets", [])]}

@app.get("/get-parameter")
def get_parameter(name: str):
    resp = ssm.get_parameter(Name=name, WithDecryption=True)
    return {"api_version": VERSION, "parameter": {"Name": name, "Value": resp["Parameter"]["Value"]}}

