. update-variables.sh

echo "Generating config"
php genconf.php pure-sni

echo "Editing HAproxy config"
scp haproxy.conf ${haproxy_user}@${haproxy_server}:~/haproxy.cfg
ssh ${haproxy_user}@${haproxy_server} "~/haproxy-edit.sh"

echo "Editing dnsmasq config"
scp dnsmasq-haproxy.conf ${dns_user}@${dns_server}:~/haproxy.conf
ssh ${dns_user}@${dns_server} "~/dnsmasq-edit.sh"
