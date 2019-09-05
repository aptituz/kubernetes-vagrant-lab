# Vagrant Kubernetes Lab

This repository contains files to build  a basic three node kubernetes cluster lab
with vagrant using puppet-bolt for configuration.

## Motivation

This lab has been created for educational purposes for the author
to figure out how easy it would be to use puppet-bolt for setting up a kubernetes
cluster with puppet-bolt and puppetforge modules.

## Pre-Requisites

This lab environment uses puppet-bolt to configure the vagrant VMs, so you need
to have puppet-bolt installed locally.

## Setup

To bring up the machines, use:

```bash
vagrant up
```

This should create the following machines:

| Hostname      | IP             |
|---------------|----------------|
| k8s-master-1  | 192.168.205.10 |
| k8s-node-1    | 192.168.205.11 |
| k8s-node-2    | 192.168.205.11 |

The vagrant file will copy the ssh-key from `~/.ssh/id_rsa.pub` to the `authorized_keys`
so you should be able to ssh into the machines right away:

```bash
ssh vagrant@192.168.205.10
```

This repo also contains a bolt configuration and inventory, so you can run bolt against the machines, e.g.

```bash
bolt command run --nodes=k8s-cluster uptime
```

The above command will NOT provision kubernetes directly. For this you have to run
a puppet-bolt plan:

```bash
bolt plan run playbooks::cluster
```

## Usage

The easiest way to tinker with the cluster is probably to login into the k8s-master-1 and
run kubectl commands from there:

```bash
vagrant ssh k8s-master-1 -- kubectl get pods -n kube-system
```

Alternatively you can copy the `~/.kube/config` to your local machine and
use a locally installed kubectl. Just keep in mind the version skew policy.

## Security warning

The way the kubernetes puppet module (https://forge.puppet.com/puppetlabs/kubernetes) works is that you pre-create certificates
with a tool called kube-tool. This has been used for this lab environment as well.
Obviously you should *not use* the configurations from this repository for
production environments.
