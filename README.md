# Agave + Docker + Cloud = Elastic Science-as-a-Service Compute Infrastructure


This is a short tutorial briefly covering how to utilize cloud infrastructure, Docker compute containers, and the Agave platform to create an elastic Science-as-a-Service Compute Infrastructure to power your digital lab. In this tutorial you will:

1. Provision Docker host machines on cloud infrastructure using Docker Machine.
2. Register compute and storage systems for use in Agave.
3. Register cloud storage services, like Amazon S3 for use in Agave.
4. Run simulations on your Docker cluster using compute containers provided and curated by the open science community.
5. Learn how to run your existing code in a secure, reproducible way using Agave's command line interface.
6. Learn how to build and run your own science codes as Docker compute containers using Agave.
7. Stand up a web application for your digital lab allowing you to access, share, and interact with your science anywhere and anytime.

## Table of Contents

* ~~[Background on the technologies](./Background.md)~~
* ~~[Prerequisites & setup](./Prerequisites.md)~~
* [Provisioning](./provisioning/README.md)
 * [Compute](./provisioning/compute/README.md)
 * [Storage](./provisioning/storage/README.md)
* [Running apps](./running/README.md)
 * [From source](./running/RunSource.md)
 * [Existing images](./running/RunImages.md)
 * [Reproducible runs](./running/ReproducibileRuns.md)
* [Building interfaces](./webapp/README.md)
