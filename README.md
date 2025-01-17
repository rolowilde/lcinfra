# lcinfra

Infrastructure for a server managed by me at Linux Centrs. Linux Centrs is a laboratory at the University of Latvia
that hosts various open source software repositories and advocates for its use in the country. This repository serves
an educational purpose and is considered suitable for small deployments.

The configuring and orchestrating stack consists of Ansible and Podman. Podman is managed by its respective role that
runs containers as systemd services (quadlets). Images are provided in the same repository and are production-ready unless
otherwise specified.

## Usage

In a Python virtual environment, install pip requirements (`pip install -r requirements.txt`) and Ansible Galaxy requirements (`ansible-galaxy install -r requirements.yml`). Create an inventory and set host/group vars according to your needs. Run playbook:

```shell
ansible-playbook site.yml
```

Tested on AlmaLinux 9.

## Configuration

### group_vars/all.yml

Global defaults to be overriden through host and/or group vars. All quadlet specs from `quadlets/` are included which may not be
desirable to you. At the bare minimum, `proxy_email` should be changed for ACME account.

### host_vars/example.yml

Vars you most likely would like to set per-host, like Tailscale authkey and firewall definitions.

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
