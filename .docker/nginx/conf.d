server {
  listen 80;
  listen [::]:80;
  server_name test.local;

  location / {
    return 301 https://$server_name$request_uri;
  }
}

server {
  listen 443 ssl;
  listen [::]:443 ssl;
  server_name test.local;

  ssl on;
  ssl_certificate /etc/nginx/certs/test.local.pem;
  ssl_certificate_key /etc/nginx/certs/test.local-key.pem;

  location / {
    proxy_pass http://wordpress;
    proxy_redirect off;

    proxy_buffering off;
    proxy_set_header      X-Real-IP $remote_addr;
    proxy_set_header      X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header      X-Forwarded-Host $server_name;
    proxy_set_header      X-Forwarded-Proto https;

  }
}