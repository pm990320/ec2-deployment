cd /home/ubuntu/deploymentscripts
echo "Moving to deploymentscripts directory"

sudo apt-get update
sudo apt-get -y upgrade

#### NGINX ####
echo 'Installing nginx...'
sudo apt-get install -y nginx
echo 'Nginx installed.'


# make sure nginx is running
sudo service nginx start
sudo update-rc.d nginx defaults
echo 'Nginx is running'

# add to available sites
sudo cp nodemusic.net /etc/nginx/sites-available/nodemusic.net
sudo cp simplysortedsoftware.com /etc/nginx/sites-available/simplysortedsoftware.com
echo 'Added sites'

# enable these sites
sudo ln -s /etc/nginx/sites-available/nodemusic.net /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/simplysortedsoftware.com /etc/nginx/sites-enabled/
echo 'Sites enabled.'

# disable default
sudo rm /etc/nginx/sites-enabled/default
echo 'Default sites disabled.'

sudo service nginx configtest
sudo service nginx reload


#### MONGODB ####
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
