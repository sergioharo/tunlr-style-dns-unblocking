# Script updates dnsmasq configuration
# and restarts the service
sudo rm /etc/haproxy/haproxy.cfg
sudo mv ~/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo service haproxy restart
