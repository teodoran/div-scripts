sudo apt-get install g++ curl libssl-dev apache2-utils
sudo apt-get install git-core
cd /opt
sudo git clone git://github.com/ry/node.git
cd node
sudo ./configure
sudo make
sudo make install