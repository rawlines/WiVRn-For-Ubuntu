# WiVRn-For-Ubuntu

[![License: GPL v3](images/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) ![CI](https://github.com/WiVRn/WiVRn/workflows/Build/badge.svg) ![Format](https://github.com/WiVRn/WiVRn/workflows/Format/badge.svg)

# Getting started

Before starting building this repo or installing the provided packages, please understand first how to use WiVRn and have at least a first experience with it using the official installing methods described in the main [WiVRn repository](https://github.com/WiVRn/WiVRn).

## What is this repository?

This repository aims to provide Ubuntu packages for WiVRn, as well as instructions to build WiVRn on Ubuntu based distributions.

At this very moment, only Ubuntu 22.04 LTS is supported.

## Are "all" the components available?

NO. This repository, currently only builds the **wivrn-server without the dashboard (GUI)**. Therefore, configuration must be done manually by editing the configuration files as described in the [configuration documentation](https://github.com/WiVRn/WiVRn).

The reason for this is that building the dashboard requires Qt6, which is not available in Ubuntu 22.04 LTS repositories, and building it from source was quite complex...

wivrnctl is also skipped for now.

## Why not use the official packages?

In my specific case, i wanted to run NMS in Oculus Quest 2 on my ZorinOS 17.3 desktop, but the official packages only provides a Flatpak package, which is not compatible with my setup (NMS installed via Steam which is not a Flatpak).

In a nutshell, i wanted to be able to run WiVRn without Flatpak, fully native in Ubuntu 22.04 based system.

## Thats fine!! How do i build it?

Before you start building this repository, please read and understand the [officual building documentation](https://github.com/rawlines/WiVRn-For-Ubuntu/blob/master/docs/building.md) in the main WiVRn repository, as you may be facing some issues that are already documented there.

Here is a quick summary of the steps needed to build the wivrn-server without dashboard on Ubuntu 22.04 LTS:

For building this repository we will use the set of scripts inside `ubuntu/jammy` folder.

### 0. IMPORTANT!!! Read this first

The build scripts are designed for an nvidia GPU system. This means that the dependencies script will install the `nvidia-cuda-toolkit` and the build script will enable `-DWIVRN_USE_NVENC=ON`. Please tune these two scripts according to your needs and dont forget to check the [official building documentation](https://github.com/WiVRn/WiVRn).

### 1. Install build dependencies

First of all, ensure you are located at the root of the repository:

```bash
cd WiVRn-For-Ubuntu
```

Then, run the install dependencies script:

```bash
. ./ubuntu/jammy/dependencies.sh

```

### 2. Build WiVRn server without dashboard

From the same terminal session, run the build script:

```bash
. ./ubuntu/jammy/buildscript.sh
```

### 3. Generate the package and install it

Finally, run the builddeb script to generate the deb package and install it:

```bash
. ./ubuntu/jammy/builddeb.sh
```

The package will be generated inside the `build` folder. You can install it using `dpkg`:

```bash
sudo dpkg -i wivrn-server_25.11.1-1_amd64.deb
```

### 4. Run WiVRn server

Before running the server, you may first read the basic [configuration documentation](https://github.com/WiVRn/WiVRn). Which tells some important details about how to configure WiVRn server and troubleshooting.

For running the server, just run:

```bash
$ wivrn-server
WiVRn 09031b9 starting
For Steam games, set command to PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1 %command%
Service published: your-server-name
```

If you want to modify the configuration, edit the file located at `~/.config/wivrn/config.json`. Dont forget to restart the server after modifying the configuration file.

From now on you can connect to the server from your VR device using WiVRn client. Enjoy!!
