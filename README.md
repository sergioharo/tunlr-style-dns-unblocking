tunlr-style-dns-unblocking
==========================

### Update
This project is a fork of the previous and now un-maintained project by trick77. Most of the refactoring was to split the json containing the servers to re-route from the configuration data about your servers. From there I've added a number of scripts to make updating much easier.

### Description
This project consists of two services to get around geo-blocking constraints from various products like Netflix, Hulu, HBO, etc... It works similarly to how serveral paid services work. It uses HTTPS forwarding (SNI Proxying) to take your requests and forward them to a server based in the US or where ever you want your traffic to look like its coming from.

### Setup
To get this set up, you'll need two servers and a machine to work on.

The first is a local server. I'm using a RaspberryPi for this. On the local server you'll need to instal dnsmasq. It'sa simple dns server that is much easier to configure than BIND. If this server has a firewall or port blocking, you'll need to open up port 53 for DNS to work. You'll also need port 22 for ssh.

The second server needs to be based in the country you want your traffic to come from. How you get this server is up to you. I'd recommend looking at Amazon, Azure, Google Cloud, etc. On this server you'll need to install HAProxy v1.5+. You'll also need to make sure that port 80 and 443 are publicly available. You'll also need port 22 for ssh.

Your work machine will need to be able to run php and shell scripts. I'm doing this on a Mac, but any unix machine should do. To make updates easier, it's also recommended to generate ssh keys so that you can login to these servers remotely without having to enter a password each time. You can use this post as a guide: https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server

### Configuration
Once you have the servers setup, you'll need to configure this project. Make copies of the following files and remove the .sample extension:
- `config.json.sample`
- `update-variable.sh.sample`

Update the new files with the IP address of your servers and any other pieces of information needed.

### Updating
To configure or update the two servers, open up a terminal and run
```
./update-proxies.sh
```
### Usage
To use, just update the DNS address of what machine you want to un-block to point to your local DNS server. For example, you can update the DNS server of your AppleTV. After that, just use the machine as normal

### Adding hosts to unblock
If you need to add additional hostnames to the unblock list, you'll need to edit `proxies.json`. To add an item, just copy this default and change the hostname and name portions. At some later point I'll write up how to find the hostnames to add. But basically you'll either need a network inspector like what is in chrome or to look at the dnsmasq logs to see the incoming requests.
```
{
  "name":"unique-name",
  "dest_addr":"www.host-to-un-block.com",
  "modes":[
    {
      "port":80,
      "mode":"http"
    },
    {
      "port":443,
      "mode":"https"
    }
  ],
  "catchall":true,
  "enabled":true
}
```
