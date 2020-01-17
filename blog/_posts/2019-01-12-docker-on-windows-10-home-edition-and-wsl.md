---
layout: post
title: "Docker on Windows 10 Home edition and WSL"
description: "How to get Docker running on Windows 10 Home with WSL"
category: "blog"
tags: [docker, termux, android, jekyll, texlive]
---

Recently I started learning about Docker for reproducible research.
I also wanted to try the _Windows Subsystem for Linux_ (WSL) in Windows 10.

### Docker on Windows 10 Home

My old Thinkpad X230 only has Windows 10 Home, which means I could not
install _Docker for Windows_, as it requires Windows 10 Professional or
Enterprise edition. The alternative for Windows 10 Home edition
is to install [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/).

### Docker engine on Windows

The docker engine does not run natively on Windows, it has to
run on a linux virtual machine. The difference is the hypervisor
of choice. _Docker for Windows_ uses a linux VM running on
Hyper-V, which runs natively on Windows 10 Pro, but not on Windows Home.
Docker Toolbox instead uses a linux VM running on Virtualbox, which runs on Windows Home.

This guideline for setting up [Docker on WSL and Windows
10](https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly)
was useful to set up docker on Windows Home.
If you prefer, you can also install the linux VM on the free VMWare player
as an alternative to Virtualbox to run the Docker engine.
Follow [this guide](https://nickjanetakis.com/blog/docker-tip-73-connecting-to-a-remote-docker-daemon)
