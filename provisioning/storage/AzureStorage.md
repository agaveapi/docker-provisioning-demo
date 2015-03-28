# Adding an Microsoft Azure Docker host as a storage system

This section describes a simple workflow for registering an Microsoft Azure Docker host as a storage system in Agave. Once registered, the resulting system can be used to hold application assets, archive data, stage inputs, etc.

## Prerequisites

* [Docker Machine](https://docs.docker.com/machine): Machine makes it really easy to create Docker hosts on your computer, on cloud providers and inside your own data center. It creates servers, installs Docker on them, then configures the Docker client to talk to them.
* [Agave CLI](https://bitbucket.org/taccaci/foundation-cli): The Agave CLI is a collection of Bash shell scripts allowing you to interact with the Agave Platform. The CLI allows you to streamline common interactions with the API and automating repetative and/or background tasks.
* [Microsoft Azure](https://azure.microsoft.com/en-us/pricing/free-trial/): You will need a valid Azure account and an active a subscription with a cert.

## Registering a Docker host system with Agave

We are assuming here that you have already completed the "Using Docker Machine to Provision on Microsoft Azure" tutorial. Once you have the system provisioned, you can reregister it with agave as a storage system. This will allow you to share limited views of the file system with others without exposing runtime data from jobs.

 To make this easier, you can use the `scripts/storage_systems_template.sh` script to create a JSON description of your system that you can send straight to the [Agave Systems API](http://preview.agaveapi.co/documentation/tutorials/system-management-tutorial/). Just run the script with the name of your machine from the "Using Docker Machine to Provision on Microsoft Azure" as an argument.

> Make sure you have already authenticated to the CLI. If this is your first time with the CLI, please see the CLI [README](https://bitbucket.org/taccaci/foundation-cli/src/master/README.md?at=master) for instructions to copy and paste.


```
$ scripts/storage_systems_template.sh $DEMO_MACHINE_NAME

```

You can use the CLI to take the JSON produced above and register the system with Agave.

```
$ scripts/storage_systems_template.sh $DEMO_MACHINE_NAME | systems-addupdate -F -
```

Now you can access your Microsoft Azure Docker host just like any other storage system in Agave

```
$ files-list -S "$AGAVE_USERNAME-$DEMO_MACHINE_NAME-storage" .
.
.bash_history
.bash_logout
.bash_profile
.bashrc
.ssh
```

## Review

In this short tutorial, we saw how we can reuse our host machine from the "Using Docker Machine to Provision on Microsoft Azure" tutorial to create a JSON description of the host and register it with Agave.

In the main tutorial, we will use this storage system as part of our workflow to run Docker compute containers on demand with the [Agave Jobs API](http://preview.agaveapi.co/documentation/tutorials/job-management-tutorial/).
