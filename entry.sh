#!/bin/bash
dev () {
	/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf && echo "Started WebServer" || echo "Error Starting web"
	git checkout dev
	while [ 1 -eq 1 ]
	do
		git pull
		make demo # TODO Build only if changes where pulled.
		sleep 10
	done
}

deploy () {
	make
	echo "Starting web Server"
	/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf
	echo "Web server Closing"
}

cd /var/www/localhost/htdocs/
[ $DEV -eq 1 ] && dev || deploy
