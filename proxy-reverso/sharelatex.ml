server {

        listen 80;
        listen 443 ssl;
        root /usr/share/nginx/html/sharelatex.ml;
        index index.html index.htm index.nginx-debian.html;

        error_page 502 /502.html;

        server_name sharelatex.ml;
        ssl_certificate /etc/ssl/cert.pem;
        ssl_certificate_key /etc/ssl/key.pem;

        if ($scheme = http) {
            return 301 https://$server_name$request_uri;
        }

        proxy_set_header  Host $host;
        proxy_set_header  X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        location /502.html {
            root /usr/share/nginx/html;
        }

        location /favicon.ico {
            root /usr/share/nginx/html;
        }

	location / {
		proxy_pass http://10.10.10.116:80;
		proxy_set_header X-Forwarded-Proto $scheme;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection "upgrade";
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_read_timeout 3m;
		proxy_send_timeout 3m;
	}
}
