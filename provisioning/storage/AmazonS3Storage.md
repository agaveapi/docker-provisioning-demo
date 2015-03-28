# Adding S3 as a storage system

This section describes a simple workflow for registering a S3 bucket as a storage system in Agave. Once registered, the resulting system can be used to hold application assets, archive data, stage inputs, etc.

## Prerequisites

* [Agave CLI](https://bitbucket.org/taccaci/foundation-cli): The Agave CLI is a collection of Bash shell scripts allowing you to interact with the Agave Platform. The CLI allows you to streamline common interactions with the API and automating repetative and/or background tasks.
* [AWS Account](https://portal.aws.amazon.com/gp/aws/developer/registration/index.html?nc2=h_ct): You should have a valid AWS account with a S3 Bucket in place, and a IAM user created for this demo with permissions to access your bucket. You should have already generated the API keys for this user and have them handy.

## Registering a S3 system with Agave

S3 is a hosted, elastic object store readily available for use. There's not much for us to set up, so we will just focus on creating the JSON description of the system to let Agave know how to access it. To make this easier, you can use the `scripts/s3_systems_template.sh` script to create a JSON description of your system that you can send straight to the [Agave Systems API](http://preview.agaveapi.co/documentation/tutorials/system-management-tutorial/). Just run the script with the name of your machine as an argument.

> Make sure you have already authenticated to the CLI. If this is your first time with the CLI, please see the CLI [README](https://bitbucket.org/taccaci/foundation-cli/src/master/README.md?at=master) for instructions to copy and paste.


```
$ scripts/s3_systems_template.sh $DEMO_MACHINE_NAME

```

You can use the CLI to take the JSON produced above and register the system with Agave.

```
$ scripts/s3_systems_template.sh $DEMO_MACHINE_NAME | systems-addupdate -F -
```

Now you can access your S3 bucket just like any other storage system in Agave

```
$ files-list -S "$AGAVE_USERNAME-s3-storage"
.
deleteme
Octocat.png
picksumipsum.txt
```

## Review

In this short tutorial, we saw how we can use Docker Machine to provision a Docker compute node on Amazon EC2. We then used the information from Docker Machine and the host VM to create a JSON description of the host and register it with Agave.

In the main tutorial, we will use this host to run Docker compute containers on demand with the [Agave Jobs API](http://preview.agaveapi.co/documentation/tutorials/job-management-tutorial/).
