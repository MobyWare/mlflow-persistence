#%%
import boto3
import os

# Create an S3 client
s3 = boto3.client(
        's3',
        endpoint_url='http://localhost:9900',
        aws_access_key_id=os.getenv('MINIO_ROOT_USER'),
        aws_secret_access_key=os.getenv('MINIO_ROOT_PASSWORD')
    )

# List all buckets
response = s3.list_buckets()

# Print the name of each bucket
print("Existing S3 buckets:")
for bucket in response['Buckets']:
    print(f"  {bucket['Name']}")