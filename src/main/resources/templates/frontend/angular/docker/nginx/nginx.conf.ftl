user nginx;
worker_processes 1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;  

    keepalive_timeout  65;

    gzip on;
    gzip_types application/javascript;
    gzip_buffers 32 8k;

    server {
        listen       80;
        server_name  localhost;
        
        root   /usr/share/nginx/html;
        
        server_tokens off;		

        location ~ /index.html|.*\.json$ {
          expires -1;        
          add_header Cache-Control 'no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0';
          include /etc/nginx/security-headers.conf;        
        }

        location ~ .*\.css$|.*\.js$ {               
          add_header Cache-Control 'max-age=31449600'; # one year        
          include /etc/nginx/security-headers.conf;        
        }

        location / {
          try_files $uri$args $uri$args/ /index.html;
          
          add_header Cache-Control 'max-age=86400'; # one day
          include /etc/nginx/security-headers.conf;       
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }

    }
}