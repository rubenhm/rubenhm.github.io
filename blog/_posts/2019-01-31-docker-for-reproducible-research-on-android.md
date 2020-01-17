---
layout: post
title: "Docker for reproducible research on Android"
description: "Use docker on Android via termux and Alpine chroot"
category: "blog"
tags: [docker,termux,android,jekyll,texlive]
---

While researching about docker I came across this [reddit 
post](https://www.reddit.com/r/docker/comments/7r7t6b/is_docker_possible_on_mobile/) 
on how to install [_anyfed_](https://github.com/nmilosev/anyfed) in [Termux](https://termux.com) on Android to run a Fedora linux image as a `chroot` on an Android phone.

A similar project, [TermuxAlpine](https://github.com/Hax4us/TermuxAlpine), 
runs [Alpine linux](https://alpinelinux.org) on Termux. 
One can then install the docker client on Alpine and set it up 
to run images from a remote Docker engine via `https` or `ssh`.
 
For example, you can set up the remote Docker host at home, securing access with the instructions in the documentation for [protecting the Docker daemon socket](https://docs.docker.com/engine/security/https/).

You can build and run Docker images, create data volumes, etc. Everything lives in the remote 
host, but it seems to work fine and you can run all kinds of things on your phone. 
For example, I have images for RStudio, and one with Ruby, Jekyll, and TeXLive for maintaining this website.



