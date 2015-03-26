# Using Docker Machine to Provision on Microsoft Azure

This section describes a simple workflow for provisioning a new Docker host on Microsoft Azure and registering it with Agave. The resulting system can be used an execution host to run compute containers via Agave.

## Prerequisites

* [Docker Machine](https://docs.docker.com/machine): Machine makes it really easy to create Docker hosts on your computer, on cloud providers and inside your own data center. It creates servers, installs Docker on them, then configures the Docker client to talk to them.
* [Agave CLI](https://bitbucket.org/taccaci/foundation-cli): The Agave CLI is a collection of Bash shell scripts allowing you to interact with the Agave Platform. The CLI allows you to streamline common interactions with the API and automating repetative and/or background tasks.
* [Microsoft Azure](https://azure.microsoft.com/en-us/pricing/free-trial/): You will need a valid Azure account and an active a subscription with a cert.


## Provisioning a new compute host

> For the most recent instructions on how to provision a new Docker host with Docker Machine, please consult the official documentation at [https://docs.docker.com/machine](https://docs.docker.com/machine).

Use the `azure` driver to provision a new Docker host on EC2.

```
$ openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
$ openssl pkcs12 -export -out mycert.pfx -in mycert.pem -name "My Certificate"
$ openssl x509 -inform pem -in mycert.pem -outform der -out mycert.cer
```

Go to the Azure portal, go to the "Settings" page (you can find the link at the bottom of the left sidebar - you need to scroll), then "Management Certificates" and upload `mycert.cer`.

Grab your subscription ID from the portal, then run `docker-machine create` with these details:

```bash
$ export DEMO_MACHINE_NAME=agave-azure-docker

$ docker-machine create --driver azure \
        --azure-subscription-id "SUB_ID" \
        --azure-subscription-cert "mycert.pem" \
        --azure-size "Small"
        $DEMO_MACHINE_NAME
```

You can also specify the arguments as environment variables:

```
$ export DEMO_MACHINE_NAME=agave-azure-docker
$ export AZURE_SUBSCRIPTION_CERT=mycert.pem
$ export AZURE_SUBSCRIPTION_ID=SUB_ID
$ export AZURE_SIZE=16

$ docker-machine create --driver azure $DEMO_MACHINE_NAME
INFO[0001] Creating Azure machine...
INFO[0073] Waiting for SSH...
INFO[0091] Configuring Machine...
INFO[0180] "agave-azure-docker" has been created and is now the active machine.
INFO[0180] To point your Docker client at it, run this in your shell: $(docker-machine env agave-azure-docker)
```  

**Note: Azure uses the machine name to generate a public dns entry. You will need to select a very unique machine name for this command to work.**

That will take a moment. Once done, your machine is up and running as a viable Docker host.

> In any real usage scenario, you would adjust your `azure-size` to levels sufficient for your particular application needs. This tutorial has relatively modest needs, so we selected a small instance.

## Registering the system with Agave

Now we need to register your new Docker host as a system with Agave. To make this easier, you can use the `scripts/execution_systems_template.sh` script to create a JSON description of your system that you can send straight to the [Agave Systems API](http://preview.agaveapi.co/documentation/tutorials/system-management-tutorial/). Just run the script with the name of your machine as an argument.

> Make sure you have already authenticated to the CLI. If this is your first time with the CLI, please see the CLI [README](https://bitbucket.org/taccaci/foundation-cli/src/master/README.md?at=master) for instructions to copy and paste.


```
$ scripts/execution_systems_template.sh $DEMO_MACHINE_NAME

```

You can use the CLI to take the JSON produced above and register the system with Agave.

```
$ scripts/execution_systems_template.sh $DEMO_MACHINE_NAME | systems-addupdate -F -
```

## Review

In this short tutorial, we saw how we can use Docker Machine to provision a Docker compute node on Amazon EC2. We then used the information from Docker Machine and the host VM to create a JSON description of the host and register it with Agave.

In the main tutorial, we will use this host to run Docker compute containers on demand with the [Agave Jobs API](http://preview.agaveapi.co/documentation/tutorials/job-management-tutorial/).
