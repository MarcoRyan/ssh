#!/bin/bash

if systemctl is-active docker &>/dev/null ;then
		echo "docker已经启动"
		echo "现在开始安装filebrowser..."
		echo ""
		mkdir /root/fb
		echo "工作目录/var/www/html/fb"

		docker pull filebrowser/filebrowser
		docker run \
			    -v /root/fb/srv:/srv \
			    -v /srv/fb/filebrowser.db:/database.db \
			    -v /srv/fb/.filebrowser.json:/.filebrowser.json \
			    -p 8001:80 \
			    filebrowser/filebrowser

else
		echo "docker未启动"
		echo "请先启动docker服务"
		echo ""
		exit 0
fi