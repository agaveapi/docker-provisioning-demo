# Provisioning Docker Compute Hosts

A Docker compute host is simply a server running a Docker daemon that will be used to instantiate the compute containers running our science code. Docker hosts can be as small or as large as you need them to be. They only need to have sufficient capacity to run your code.

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
* [Provisioning on Amazon EC2](./AmazonEC2Compute.md)
* [Provisioning on Microsoft Azure](./AzureCompute.md)
