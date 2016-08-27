echo "Moving to deploymentscripts directory"
cd /home/ubuntu/deploymentscripts

echo "Running apt-get update and apt-get upgrade."
sudo apt-get update
sudo apt-get -y upgrade

#### DOCKER ####
echo "Installing docker..."
wget -qO- https://get.docker.com/ | sh
echo "Docker installed."


echo "Adding user to docker group..."
sudo usermod -aG docker ubuntu

echo "Starting docker service..."
sudo service docker start


#### CERTBOT - LETS ENCRYPT - SSL CERTIFICATES ####
echo "Installing letsencrypt..."
sudo apt-get install letsencrypt
echo "letsencrypt installed."

echo "Generating certificates..."
letsencrypt certonly --webroot -w ./certs -d www.simplysortedsoftware.com -d www.nodemusic.net -d nodemusic.net
echo "Certificates generated."


echo "Setting up cron job to renew certificates..."
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "27 * * * * letsencrypt renew" >> mycron
#install new cron file
crontab mycron
rm mycron
echo "Set up cron job to run at 27 minutes past every hour."


#### NGINX PROXY ####
echo "Stopping any previously running container instance..."
docker rm $(docker stop $(docker ps -a -q --filter ancestor=jwilder/nginx-proxy --format="{{.ID}}"))
echo "Previously running containers stopped."

echo "Running nginx-proxy container..."
docker run -d -p 80:80 -p 443:443 -v ./certs:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
echo "nginx-proxy container running."

echo "Ready for deployments for services."

#### AWS CLI ####
sudo apt-get -y install python-pip
sudo pip install awscli
echo "Installed awscli"