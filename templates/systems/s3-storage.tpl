{
    "description": "Amazon S3 Storage Account",
    "environment": null,
    "id": "%AGAVE_USERNAME-s3-storage",
    "name": "Amazon S3 Object Store",
    "site": "aws.amazon.com",
    "status": "UP",
    "storage": {
        "host": "s3-website-us-east-1.amazonaws.com",
        "port": 443,
        "protocol": "S3",
        "rootDir": "/",
        "homeDir": "/",
        "container": "%AWS_BUCKET_NAME",
        "auth": {
            "publicKey": "%AWS_ACCESS_KEY",
            "privateKey": "%AWS_SECRET_KEY",
            "type": "APIKEYS"
        }
    },
    "type": "STORAGE"
}
