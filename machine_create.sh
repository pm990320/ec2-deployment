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

#### NGINX PROXY ####
echo "Stopping any previously running container instance..."
docker rm $(docker stop $(docker ps -a -q --filter ancestor=jwilder/nginx-proxy --format="{{.ID}}"))
echo "Previously running containers stopped."

echo "Running nginx-proxy container..."
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
echo "nginx-proxy container running."

echo "Ready for deployments for services."

#### AWS CLI ####
sudo apt-get -y install python-pip
sudo pip install awscli
