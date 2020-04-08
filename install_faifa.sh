git clone https://github.com/avian2/faifa
cd faifa
apt-get install git autoconf build-essential -y
apt-get install libpcap-dev -y
apt-get install libevent-dev -y
autoreconf --install
./configure
make
sudo make install
ldconfig -v
