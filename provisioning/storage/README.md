# Provisioning Storage Hosts

A storage system is simply a server or cloud service that you designate to handle data persistence. You may create multiple storage systems, reuse existing compute systems, or pick a separate, centralized system such as the [iPlant Data Store]() or [Amazon S3]() to store your data. Agave will handle the scheduling and movement of data into and out of your execution system for you regardless of where they are physically located.

In this tutorial we will show how we can reuse the compute containers we defined in our [Provisioning Docker Compute Hosts](../compute/README.md) tutorial as storage systems, as well as how to register a S3 bucket as a storage system. Later on, in the section on [Running apps](../../running/README.md), we will see the pros and cons of using a storage host separate from the execution host.


This section contains two short tutorials on how to provision Docker compute hosts on Amazon EC2 and Microsoft Azure. You can take either tutorial and substitute another cloud provider such as OpenStack, Google Compute Engine, or Helion and the rest of the tutorials will work the same.

> If you already have a server running Docker available, you may substitute that for any of the servers in this section. You simply need to swap out the values for your server when registering it with Agave.

Each tutorial follows the same format.

1. Use Docker Machine to start a VM on a commercial cloud provider. This will:  
 a. Create a virtual private network for the VM
 b. Generate a set of ssh keys to access the VM
 c. Start the VM
 d. Install Docker on the VM
 e. Configure TLS and the REST API on the Docker daemon.
 f. Start up the Docker daemon.
2. Use the machine information to generate a JSON description of the Docker host that we can use to register it as an execution system with Agave.  
3. Use the Agave CLI to call the Agave Systems API and register the system.

Once you have a compute system registered, you can move on to the section on [Running apps](../../running/README.md) and start using your new system to run code.

> This tutorial series shows a good general approach for registering personal systems to run your scientific applications as Docker compute containers with Agave. If you plan on using your Docker hosts in a shared environment, or plan on allowing multiple users to run compute containers on your host, you should learn more about queues, quotas, and security best practices in the [Agave documentation](http://preview.agaveapi.co/documentation/tutorials/system-management-tutorial/).


### Table of Contents
* [Provisioning on Amazon EC2](./AmazonEC2Storage.md)
* [Provisioning on Microsoft Azure](./AzureStorage.md)
* [Provisioning on Amazon S3](./AmazonS3Storage.md)
