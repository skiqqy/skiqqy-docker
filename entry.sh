#!/bin/bash
# Run the API
api () {
	fuser -k 8199/tcp # Kill the api if it is running
	./api.sh
}

# Deploy Dev
dev () {
	/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf && echo "Started WebServer" || echo "Error Starting web"
	git checkout dev
	api # TODO: Move to loop, and restart iff changes are pulled
	while [ 1 -eq 1 ]
	do
		git pull
		make demo # TODO Build only if changes where pulled.
		sleep 60
	done
}

# Production Deploy
deploy () {
	make
	echo "Starting web Server"
	/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf
	echo "Web server Closing"
}

cd /var/www/localhost/htdocs/
[ $DEV -eq 1 ] && dev || deploy
