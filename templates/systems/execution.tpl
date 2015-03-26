{
    "description": "Docker compute host running on %DOCKER_HOST_PROVIDER. Instance id %DOCKER_HOST_INSTANCE_ID",
    "environment": null,
    "executionType": "CLI",
    "id": "%AGAVE_USERNAME-%DEMO_MACHINE_NAME-compute",
    "login": {
        "auth": {
            "username": "%DOCKER_HOST_USERNAME",
            "publicKey": "%DOCKER_HOST_PUBLICKEY",
            "privateKey": "%DOCKER_HOST_PRIVATEKEY",
            "type": "SSHKEYS"
        },
        "host": "%DOCKER_HOST_IP",
        "port": %DOCKER_HOST_PORT,
        "protocol": "SSH"
    },
    "maxSystemJobs": 100,
    "maxSystemJobsPerUser": 10,
    "name": "Docker Host %DEMO_MACHINE_NAME (%DOCKER_HOST_PROVIDER)",
    "public": false,
    "queues": [
        {
            "name": "default",
            "default": true,
            "maxJobs": 10,
            "maxUserJobs": 10,
            "maxNodes": 1,
            "maxProcessorsPerNode": 1,
            "maxMemoryPerNode": "2GB",
            "maxRequestedTime": "72:00:00"
        }
    ],
    "scheduler": "FORK",
    "scratchDir": "%DOCKER_HOST_WORKD",
    "site": "%DOCKER_HOST_PROVIDER",
    "startupScript": null,
    "status": "UP",
    "storage": {
        "host": "%DOCKER_HOST_IP",
        "port": %DOCKER_HOST_PORT,
        "protocol": "SFTP",
        "rootDir": "/",
        "homeDir": "/home/%DOCKER_HOST_USERNAME",
        "auth": {
            "username": "%DOCKER_HOST_USERNAME",
            "publicKey": "%DOCKER_HOST_PUBLICKEY",
            "privateKey": "%DOCKER_HOST_PRIVATEKEY",
            "type": "SSHKEYS"
        }
    },
    "type": "EXECUTION",
    "workDir": "%DOCKER_HOST_WORKD"
}
