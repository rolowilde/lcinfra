# lcinfra

Infrastructure for a server managed by me at Linux Centrs. Linux Centrs is a laboratory at the University of Latvia
that hosts various open source software repositories and advocates for its use in the country. This repository serves
an educational purpose and is considered suitable for small deployments.

The configuring and orchestrating stack consists of Ansible and Podman. Podman is managed by its respective role that
runs containers as systemd services (quadlets). Images are provided in the same repository and are production-ready unless
otherwise specified.

## Services

- Reverse proxy, static file servers (Caddy)
- Repository mirroring

## Usage

Create a virtual environment, install requirements, edit inventory, and run playbook:

```shell
python -m venv venv
source ./venv/bin/activate
pip install -r requirements.txt
ansible-galaxy install -r requirements.yml
cp inventory.example.yml inventory.yml
$EDITOR inventory.yml
ansible-playbook site.yml
```

Tested on AlmaLinux 9.

### Vagrant

Testing in a local development environment can be done in Vagrant. This will spin up a libvirt/QEMU virtual machine and provision it
with Ansible:

```shell
vagrant plugin install vagrant-libvirt
vagrant up --provider libvirt --provision
```

No provider other than libvirt is supported.

## Configuration

Default configuration is found in `group_vars/all.yml` which you may override with host/group vars. It is advisable to set `proxy_email`
at the bare minimum for ACME account. Dev hosts should be placed under `dev` child group of `lc` that already has configuration prepared
for them. Default Vagrant host is automatically included in the group.

## Containers

Containers should have their configuration defined in the image during build (not bind mounted). If possible, environment variables
are passed to the container per host via Jinja templating. Some images may have support for development or production environments,
with the latter always omitted from public git repository.

Internal `web` containers are served to the public Internet by the central `proxy` container over the `proxy` bridged network.

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
