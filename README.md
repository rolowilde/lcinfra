# lcinfra

Infrastructure for a server managed by me at Linux Centrs. Linux Centrs is a laboratory at the University of Latvia
that hosts various open source software repositories and advocates for its use in the country. This repository serves
an educational purpose and is considered suitable for small deployments.

The configuring and orchestrating stack consists of Ansible and Podman. Podman is managed by its respective role that
runs containers as systemd services (quadlets).

## Services

- Reverse proxy, static file servers - Caddy
- Repository mirroring - rsync & supercronic
  - Arch Linux

## Usage

Create a Python virtual environment and install requirements:

```shell
python -m venv venv
source ./venv/bin/activate
pip install -r requirements.txt
ansible-galaxy install -r requirements.yml
```

Further steps will depend on your deployment environment.

### Vagrant

Testing in a local development environment can be done in Vagrant. This will spin up a libvirt/QEMU virtual machine and provision it
with Ansible:

```shell
vagrant plugin install vagrant-libvirt
vagrant up --provider libvirt --provision
```

No provider other than libvirt is supported.

### Production

Clone this repository and set the origin to a private downstream; as upstream, use this repostiory.

```shell
git remote set-url origin <downstream.git>
git remote add upstream https://github.com/rolowilde/lcinfra.git
```

Create an `inventory.yml` file and include hosts in the `lc` group. Override `all.yml` variables to configure roles and services.
Run playbook:

```shell
ansible-playbook -KJ site.yml
```

Tested on Alma Linux 9.

## Rationale

### Rootful Podman

A daemonless alternative to Docker backed by Red Hat and is preferred on Enterprise Linux distributions (AlmaLinux, in this case).
Rootless containers come with their own caveats I decided not to deal with (user namespaces, userland networking, etc.) thus rootful
seems the way to go. SELinux already takes care of some of the security implications of rootful containers.

Previously, Docker and docker-compose were used.

### Caddy

Alleviates the bolierplate problem with nginx by having automatic HTTPS and good defaults. Also provides a pleasant web frontend for
file servers. Before that, nginx fancyindex module was employed which was its own can of worms.

### Supercronic

Seems to be the natural choice for a containarized job scheduler rather than system cron, which used to be managed by Ansible for mirror syncs.
