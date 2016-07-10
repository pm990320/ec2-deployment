server {
	listen 80;
	server_name www.simplysortedsoftware.com;
	
	location / {
		proxy_pass http://ec2-54-84-14-194.compute-1.amazonaws.com:8001;
	}
}