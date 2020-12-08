#!/bin/bash

echo -e "%{F#49FF3D} %{F#e2ee6a}$(/usr/sbin/ifconfig tun0 2>/dev/null | grep 'inet ' | awk '{print $2}')%{u-}"
