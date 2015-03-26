{
    "description": "Docker storage host running on %DOCKER_HOST_PROVIDER. Instance id %DOCKER_HOST_INSTANCE_ID",
    "environment": null,
    "id": "%AGAVE_USERNAME-%DEMO_MACHINE_NAME-storage",
    "name": "Docker Storage Host %DEMO_MACHINE_NAME (%DOCKER_HOST_PROVIDER)",
    "public": false,
    "site": "%DOCKER_HOST_PROVIDER",
    "status": "UP",
    "storage": {
        "host": "%DOCKER_HOST_IP",
        "port": %DOCKER_HOST_PORT,
        "protocol": "SFTP",
        "rootDir": "/home/%DOCKER_HOST_USERNAME",
        "homeDir": "/",
        "auth": {
            "username": "%DOCKER_HOST_USERNAME",
            "publicKey": "%DOCKER_HOST_PUBLICKEY",
            "privateKey": "%DOCKER_HOST_PRIVATEKEY",
            "type": "SSHKEYS"
        }
    },
    "type": "STORAGE"
}
