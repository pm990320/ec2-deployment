cd /home/ubuntu/deploymentscripts

sudo apt-get update
sudo apt-get -y upgrade

#### NGINX ####
echo 'Installing nginx...'
sudo apt-get install nginx
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
# test if output is not 'OK'
echo 'New configuration test passed.'

sudo service nginx reload
echo 'Nginx service reloaded.'


#### DOCKER ####
# sudo wget -qO- https://get.docker.com/ | sh
# echo 'Docker installed.'
