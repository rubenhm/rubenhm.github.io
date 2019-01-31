---
layout: post
title: "Docker for reproducible research-_On Android_"
description: "Use docker on Android via termux and Alpine chroot"
category: "blog"
tags: [docker,termux,android,jekyll,texlive]
---

# Docker on Android

While researching about docker I came across this [reddit post]() 
on running Alpine linux in [Termux]() on Android as a `chroot`. 
From there, I was able to install docker as client inside the 
Alpine chroot and set up a remote docker host at home to which 
I could connect via OpenVPN.


