#!/bin/sh

pacman -Qe > /root/pkglist-git/pkglist.txt
cd /root/pkglist-git
git add pkglist.txt
git commit -m "$(date)"
git push
