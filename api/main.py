import requests
import os
from fastapi import FastAPI

app = FastAPI()
AUX_URL = os.getenv("AUX_URL", "http://auxiliary-svc.auxiliary.svc.cluster.local:8080")

@app.get("/buckets")
def list_buckets():
    response = requests.get(f"{AUX_URL}/buckets")
    return {
        "main_api_version": "1.0.0",
        "aux_service_version": response.json().get("version"),
        "buckets": response.json().get("buckets")
    }

@app.get("/parameters")
def list_parameters():
    response = requests.get(f"{AUX_URL}/parameters")
    return {
        "main_api_version": "1.0.0",
        "aux_service_version": response.json().get("version"),
        "parameters": response.json().get("parameters")
    }

