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

