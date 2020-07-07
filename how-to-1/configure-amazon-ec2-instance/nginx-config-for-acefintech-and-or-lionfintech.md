# nginx config for ACEFintech and/or LionFintech

ACEFintech and LionFintech has SpringBoot based backend application and React based GUI.  
Serving https requests and integrate gui with backend we using nginx load balancer.

ACEFintech is served within "/netbank" url and LionFintech is served "/lionfintech" url.  
ACEFintech backend is served from "http://localhost:8080/\*".  
LionFintech backend is served from "http://localhost:8085/\*"

{% code title="/etc/nginx/nginx.conf" %}
```text
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    server_tokens off;

    gzip          on;
    gzip_types    text/plain text/css;
    gzip_comp_level  3;

    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options SAMEORIGIN;
    add_header X-XSS-Protection "1; mode=block";

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       8081 default_server;
        listen       [::]:8081 default_server;
        server_name  _;
        root         /srv/nginx/acefintech/;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

	location /netbank/ {
	    try_files $uri $uri/ /netbank/login;
	}	
        
	location /lionfintech/ {
            try_files $uri $uri/ /lionfintech/login;
        }

# LionFinech urls		
	location ~ ^/lionfintech/api/(/?)(.*) {
	    proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://10.2.0.95:8085/$2$is_args$args;
            error_log /var/log/nginx/api_error.log debug;
	}

# ACEFintech urls
        location ~ ^/api/(/?)(.*) {
# Settings for local GUI development
#            set $cors '';
#	    if ($http_origin ~ '^https?://(localhost:3000|acefintech\.mlabs\.dpc\.hu)') {
#           	set $cors 'true';
#	    }	
#
#	    if ($cors = 'true') {
#            	add_header 'Access-Control-Allow-Origin' "$http_origin" always;
#            	add_header 'Access-Control-Allow-Credentials' 'true' always;
#            	add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
#            	add_header 'Access-Control-Allow-Headers' 'Accept,Authorization,Cache-Control,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,User-Agent,X-Requested-With' always;
            	# required to be able to read Authorization header in frontend
#            	add_header 'Access-Control-Expose-Headers' 'Authorization' always;
#	    }

#	    if ($request_method = 'OPTIONS') {
            	# Tell client that this pre-flight info is valid for 20 days
#            	add_header 'Access-Control-Max-Age' 1728000;
#            	add_header 'Content-Type' 'text/plain charset=UTF-8';
#           	add_header 'Content-Length' 0;
#            	return 204;
#	    }

#	    set $http_origin 'acefintech.mlabs.dpc.hu';
	    proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://10.2.0.95:8080/$2$is_args$args;
	    error_log /var/log/nginx/api_error.log debug;
        }


        location / {
        }


        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
}

```
{% endcode %}

Because

