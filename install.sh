#!/bin/sh

apt-get update
apt-get install nginx -y
apt-get install sysstat -y

echo "" > /etc/nginx/conf.d/deny.conf

echo "
worker_processes  1;

events {
    worker_connections  1024;
}

http {
    server {
        listen  80;
        server_name  localhost;

        location / {
            proxy_pass http://localhost:8000;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        }
    	include /etc/nginx/conf.d/deny.conf;
	}
}
" > /etc/nginx/nginx.conf

#service nginx restart
nginx -s reload
service nginx status
