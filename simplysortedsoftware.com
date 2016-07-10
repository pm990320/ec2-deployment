server {
	listen 80;
	server_name www.simplysortedsoftware.com;
	
	location / {
		proxy_pass http://http://ec2-54-84-14-194.compute-1.amazonaws.com:8001
		proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
	}
}