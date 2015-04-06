sudo rm /etc/dnsmasq.d/haproxy.conf
sudo mv ~/haproxy.conf /etc/dnsmasq.d/haproxy.conf
sudo service dnsmasq restart