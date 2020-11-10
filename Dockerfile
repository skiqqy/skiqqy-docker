FROM alpine:latest

EXPOSE 80

# 1 Means dev version
ENV DEV=0

RUN apk update && apk add lighttpd wget git make gcc libc-dev bash

# Lighttpd Setup
RUN mkdir -p /var/www/localhost/htdocs/stats /var/log/lighttpd /var/lib/lighttpd

RUN sed -i -r 's#\#.*server.port.*=.*#server.port          = 80#g' /etc/lighttpd/lighttpd.conf && \
	sed -i -r 's#.*server.stat-cache-engine.*=.*# server.stat-cache-engine = "simple"#g' /etc/lighttpd/lighttpd.conf && \
	sed -i -r 's#\#.*server.event-handler = "linux-sysepoll".*#server.event-handler = "linux-sysepoll"#g' /etc/lighttpd/lighttpd.conf && \
	chown -R lighttpd:lighttpd /var/www/localhost/ && \
	chown -R lighttpd:lighttpd /var/lib/lighttpd && \
	chown -R lighttpd:lighttpd /var/log/lighttpd && \
	sed -i -r 's#\#.*mod_status.*,.*#    "mod_status",#g' /etc/lighttpd/lighttpd.conf && \
	sed -i -r 's#.*status.status-url.*=.*#status.status-url  = "/stats/server-status"#g' /etc/lighttpd/lighttpd.conf && \
	sed -i -r 's#.*status.config-url.*=.*#status.config-url  = "/stats/server-config"#g' /etc/lighttpd/lighttpd.conf

RUN rm -rf /var/www/localhost/htdocs && git clone https://github.com/skiqqy/skiqqy.github.io /var/www/localhost/htdocs

ADD entry.sh /entry.sh
ENTRYPOINT ["sh", "/entry.sh"]
