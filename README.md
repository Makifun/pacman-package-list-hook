# Automatically push a list of your installed packages to git

Keep track of newly added/removed packages after every pacman run

1. cp pkglist.hook to your /etc/pacman.d/hooks/
2. mkdir /root/pkglist-git and init a git repo there
3. cp pkglist.sh into /root/pkglist-git and do chmod +x pkglist.sh
4. Manually run pkglist.sh to make sure it works
5. Install/remove some package and the hook should update pkglist.txt
6. ????
7. Profit
