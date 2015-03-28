# Prerequisites and Setup

For this tutorial, you will be building and pushing Docker images, provisioning new virutal machines, and interacting with the Agave API. There are many ways we could do this, but in this tutorial, we will be using Docker Machine, and the Agave CLI to streamline the process. Installation instructions for each are given here.

## Docker & Docker Machine

Complete installation instructions for [Docker](https://docs.docker.com/installation/mac/) and [Docker Machine](https://docs.docker.com/machine/) are available for your platform at the links below:

* [Installing Docker](https://docs.docker.com/installation/mac/)
* [Installing Docker Machine](https://docs.docker.com/machine/)


## The Agave CLI

### Installation

The Agave CLI is a set of Bash scripts making the full functionality of the Agave Platform available at the command line. You can pull it down from our Git repository, or use the public Docker image. Instructions for both are below.

#### Docker Installation

The Agave CLI is available as a Docker image from the [Docker Hub](https://registry.hub.docker.com/u/agaveapi/agave-cli/). You run the CLI in a container with the following command.

```bash
docker run -i -t –rm -v $HOME/.agave:/root/.agave -e agaveapi/agave-cli bash
```

#### Manual installation

Before we begin, let's install the Agave command line interface (CLI). The CLI lets you easily interact with Agave's REST APIs and learn the various service URLs and interaction patterns.

1) Pull down the cli

```bash
git clone http://bitbucket.org/taccaci/foundation-cli.git agave-cli
```

2) Add the bin directory to your path

```bash
export PATH=$PATH:`pwd`/agave-cli/bin
```

3) Get your API client keys

```bash
tenants-init -S -t 2
clients-create -N cli-demo -D "my cli demo client" -u "$IPLANT_USERNAME" -p "$IPLANT_PASSWORD" -S
```

### Setup

Now that you have a copy of the CLI, it's time to setup your environment.

#### Retrieve your API keys

In order to communicate with Agave, you will need a set of API keys. You can use the clients-create command to create a set.

```bash
client-create -N cli_client -D “Just a test api client” -u "$AGAVE_USERNAME" -p "$AGAVE_PASSWORD" -S
```

The -S option will save your api keys in your session cache directory, AGAVE_CACHE_DIR.

#### Login

Now that you have the CLI installed and have a set of API keys, you can authenticate and get to work.

```bash
auth-tokens-create -S -p $IPLANT_PASSWORD
```

After authenticating, your auth token will be cached on your local system. Tokens are valid for 4 hours at a time. You can refresh them before or after they expire by running the following command.

```bash
auth-tokens-refresh -S
```

This will pull a new token for you valid for another 4 hours.
