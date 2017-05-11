<!-- [![Docker Repository on Quay.io](https://quay.io/repository/sameersbn/skypeforlinux/status "Docker Repository on Quay.io")](https://quay.io/repository/sameersbn/skypeforlinux) -->

Fork from sameersbn/skypeforlinux:0.0.3 . Here is  used the  latest stable fkypeforlinux 
(for now  it is  skypeforlinux 5.0.1 beta)

# WARNING: Work in Progress, may not work as advertised. Contributions welcome.

# enko/skypeforlinux:latest

- [Introduction](#introduction)
  - [Contributing](#contributing)
  - [Issues](#issues)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [How it works](#how-it-works)
  - [Limitations](#limitations)
- [Maintenance](#maintenance)
  - [Upgrading](#upgrading)
  - [Uninstallation](#uninstallation)
  - [Shell Access](#shell-access)

# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image with [Skype](http://www.skype.com) for Linux (beta) with support for audio/video calls.

The image uses [X11](http://www.x.org) and [Pulseaudio](http://www.freedesktop.org/wiki/Software/PulseAudio/) unix domain sockets on the host to enable audio/video support in Skype. These components are available out of the box on pretty much any modern linux distribution.

## Contributing

If you find this image useful here's how you can help:

- Send a pull request with your awesome features and bug fixes
- Help users resolve their [issues](../../issues?q=is%3Aopen+is%3Aissue).
- Support the development of the original image (sameersbn/docker-skypeforlinux
) with a [donation](http://www.damagehead.com/donate/)

## Issues

Before reporting your issue please try updating Docker to the latest version and check if it resolves the issue. Refer to the Docker [installation guide](https://docs.docker.com/installation) for instructions.

SELinux users should try disabling SELinux using the command `setenforce 0` to see if it resolves the issue.

If the above recommendations do not help then [report your issue](../../issues/new) along with the following information:

- Output of the `docker version` and `docker info` commands
- The `docker run` command or `docker-compose.yml` used to start the image. Mask out the sensitive bits.
- Please state if you are using [Boot2Docker](http://www.boot2docker.io), [VirtualBox](https://www.virtualbox.org), etc.

# Getting started

## Installation
<!-- regular html comment -->
<!--- special completely ignored comment --> 
<!-- Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/sameersbn/skypeforlinux) and is the recommended method of installation. -->

<!-- **Note**: Builds are also available on [Quay.io](https://quay.io/repository/sameersbn/skypeforlinux) -->

```bash
docker pull enko/skypeforlinux:latest
```

Alternatively you can build the image yourself. 

```bash
docker build -t enko/skypeforlinux github.com/enko-tm/docker-skypeforlinux
```

With the image locally available, install the wrapper scripts using:

```bash
docker run -it --rm \
  --volume /usr/local/bin:/target \
  enko/skypeforlinux:latest install
```

This will install a wrapper script to launch `skypeforlinux`.

> **Note**
>
> If Skype is installed on the the host then the host binary is launched instead of starting a Docker container. To force the launch of Skype in a container use the `skypeforlinux-wrapper` script. For example, `skypeforlinux-wrapper skypeforlinux` will launch Skype inside a Docker container regardless of whether it is installed on the host or not.

## How it works

The wrapper scripts volume mount the X11 and pulseaudio sockets in the launcher container. The X11 socket allows for the user interface display on the host, while the pulseaudio socket allows for the audio output to be rendered on the host.

When the image is launched the following directories are mounted as volumes

 - `${HOME}/.config/skypeforlinux`
 - `XDG_DOWNLOAD_DIR` or if it is missing `${HOME}/Downloads`

This makes sure that your profile details are stored on the host and files received via Skype are available on your host in the appropriate download directory.

## Limitations

- Minimize to system tray does not work.  : @UPDATE   in  elementary OS Loki Minimize to system tray DOES work.

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull enko/skypeforlinux:latest
  ```

  2. Run `install` to make sure the host scripts are updated.

  ```bash
  docker run -it --rm \
    --volume /usr/local/bin:/target \
    enko/skypeforlinux:latest install
  ```

## Uninstallation

```bash
docker run -it --rm \
  --volume /usr/local/bin:/target \
  enko/skypeforlinux:latest uninstall
```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it skypeforlinux bash
```
