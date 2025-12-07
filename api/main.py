from fastapi import FastAPI
import boto3
import os

app = FastAPI()

aws_region = os.getenv("AWS_REGION", "eu-west-3")

ssm = boto3.client("ssm", region_name=aws_region)

@app.get("/")
def health():
    return {"status": "ok"}

@app.get("/secret")
def get_secret():
    param = ssm.get_parameter(
        Name=os.getenv("SSM_PARAMETER_NAME"),
        WithDecryption=True
    )
    return {"value": param["Parameter"]["Value"]}

