# Using Docker Machine to Provision on Amazon EC2

This section describes a simple workflow for provisioning a new Docker host on Amazon EC2 and registering it with Agave. The resulting system can be used an execution host to run compute containers via Agave.

## Prerequisites

* [Docker Machine](https://docs.docker.com/machine): Machine makes it really easy to create Docker hosts on your computer, on cloud providers and inside your own data center. It creates servers, installs Docker on them, then configures the Docker client to talk to them.
* [Agave CLI](https://bitbucket.org/taccaci/foundation-cli): The Agave CLI is a collection of Bash shell scripts allowing you to interact with the Agave Platform. The CLI allows you to streamline common interactions with the API and automating repetative and/or background tasks.
* [AWS Account](https://portal.aws.amazon.com/gp/aws/developer/registration/index.html?nc2=h_ct): You should have a valid AWS account with a VPC created, and a IAM user created for this demo with permissions to run EC2 instances and access S3. You should have already generated the API keys for this user and have them handy.

## Provisioning a new host

> For the most recent instructions on how to provision a new Docker host with Docker Machine, please consult the official documentation at [https://docs.docker.com/machine](https://docs.docker.com/machine).

Use the `amazonec2` driver to provision a new Docker host on EC2:

```bash
$ export DEMO_MACHINE_NAME=agave-ec2-docker

$ docker-machine create --driver amazonec2 \
        --amazonec2-access-key YOUR_KEY \
        --amazonec2-instance-type t2.micro  \
        --amazonec2-root-size 16  \
        --amazonec2-secret-key YOUR_SECRET  \
        --amazonec2-vpc-id YOUR_VPC  \
        $DEMO_MACHINE_NAME
```

you can also specify the arguments as environment variables:

```
$ export DEMO_MACHINE_NAME=agave-ec2-docker
$ export AWS_ACCESS_KEY_ID=YOUR_KEY
$ export AWS_SECRET_ACCESS_KEY=YOUR_SECRET
$ export AWS_ROOT_SIZE=16
$ export AWS_INSTANCE_TYPE=t2.micro
$ export AWS_VPC_ID=YOUR_VPC

$ docker-machine create --driver amazonec2 $DEMO_MACHINE_NAME
INFO[0000] Launching instance...
INFO[0023] Waiting for SSH on 52.4.51.99:22
INFO[0091] Configuring Machine...
INFO[0180] "agave-ec2-docker" has been created and is now the active machine.
INFO[0180] To point your Docker client at it, run this in your shell: $(docker-machine env agave-ec2-docker)
```  

That will take a moment. Once done, your machine is up and running as a viable Docker host.

> In any real usage scenario, you would adjust your `amazonec2-instance-type` and `amazonec2-root-size` to levels sufficient for your particular application needs. This tutorial has relatively modest needs, so we selected the default host.

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
