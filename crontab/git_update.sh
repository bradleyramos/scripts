#!/bin/sh
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

git -C /Users/admin/github fetch
git -C /Users/admin/github reset --hard
git -C /Users/admin/github pull origin master
chmod 711 /Users/admin/github/WITup\ app/WITup.app/Contents/MacOS/WITup
