---
layout: post
title: "Docker for reproducible research--On Android"
description: "Use docker on Android via termux and Alpine chroot"
category: "blog"
tags: [docker,termux,android,jekyll,texlive]
---

Recently I started learning about Docker for reproducible research. I also wanted to try the Windos Subsystem for Linux in Windows 10. My old Thinkpad X230 only has Windows 10 Home, which means I could not install Docker for Windows and the Docker engine does not run on WSL.

I found this guideline for [Docker on WSL and Windows 10]() which has an aside for setting up the docker engine inside an Alpine virtual machine running on the free VMWare Player in Windows and Docker CE running on WSL.

The idea is to install VMWare on Windows, add an Alpine VM and install Docker CE there, configure it to be the main docker daemon and connect to it from inside WSL. Essentially the docker client in WSL connects to the remote docker engine via `tcp` by changing the daemon settings in file `/etc/docker/daemon.json` inside the Alpine VM and setting the environmental variable `DOCKER_HOST` inside WSL.

While researching about docker I came across this [reddit post]() on running Alpine linux in [Termux]() on Android as a `chroot`. From there, I was able to install docker as client inside the Alpine chroot and set up a remote docker host at home to which I could connect via OpenVPN.


