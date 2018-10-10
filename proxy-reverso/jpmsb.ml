server {

        listen 80;
        listen 443 ssl;
        root /usr/share/nginx/html/jpmsb.ml;
        index index.html index.htm index.nginx-debian.html;

        error_page 502 /502.html;

        server_name jpmsb.ml;
        ssl_certificate /etc/ssl/cert.pem;
        ssl_certificate_key /etc/ssl/key.pem;

        if ($scheme = http) {
            return 301 https://$server_name$request_uri;
        }

        access_log /usr/share/nginx/html/jpmsb.ml/logs/acesso.log;
        error_log /usr/share/nginx/html/jpmsb.ml/logs/erro.log;

        proxy_set_header Host $host;
	      proxy_set_header X-Real-IP $remote_addr;
	      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        location /502.html {
            root /usr/share/nginx/html;
        }

        location /favicon.ico {
            root /usr/share/nginx/html;
        }

        location /logs {
            root /usr/share/nginx/html/jpmsb.ml;
        }

        location / {
            proxy_set_header   Host   $host;
            proxy_set_header   X-Real-IP  $remote_addr;
            proxy_http_version 1.1;
            proxy_set_header Connection "";
            proxy_pass   http://10.10.10.112:80/;
        }

        location /http-bind {
            proxy_pass  http://10.10.10.111:5280/http-bind;
            proxy_set_header Host $host;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /register_web {
            proxy_pass  http://10.10.10.111:5280/register_web;
            proxy_set_header Host $host;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /status {
            proxy_pass  http://10.10.10.111:5280/status;
            proxy_set_header Host $host;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /admin {
            proxy_pass  http://10.10.10.111:5280/admin;
            proxy_set_header Host $host;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /chat/ {
            proxy_set_header   Host   $host;
            proxy_set_header   X-Real-IP  $remote_addr;
            proxy_http_version 1.1;
            proxy_set_header Connection "";
            proxy_pass   http://10.10.10.112:80/chat/;
        }

        location /motioneye/ {
            proxy_pass http://10.10.10.113:8765/;
            proxy_read_timeout 120s;
            access_log off;
        }

        location /cam1 {
            proxy_pass http://10.10.10.113:7001;
        }

        location /cam2 {
            proxy_pass http://10.10.10.113:7002; 
        }

        location /cam3 {
            proxy_pass http://10.10.10.113:7003; 
        }

        location /cam4 {
            proxy_pass http://10.10.10.113:7004; 
        }

        location /cam5 {
            proxy_pass http://10.10.10.113:7005; 
        }

        location /cam6 {
            proxy_pass http://10.10.10.113:7006; 
        }

        location /cam7 {
            proxy_pass http://191.36.8.34:8090;
        }

        location /blog/ {
            proxy_set_header X-Forwarded-Host $host;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_pass http://10.10.10.114:80/blog/;
        }

        location /wiki/ {
            proxy_pass http://10.10.10.115:80/wiki/;
        }

        location /remoteapp/ {
            proxy_pass http://10.10.10.110:80/remoteapp/;
        }

}
