### php-apache-certbot
Docker image with php, apache and certbot. Based on webdevops/php-apache

Docker hub : [monkeycompany/php-apache-certbot](https://hub.docker.com/r/monkeycompany/php-apache-certbot/)

Github project : [monkey-company/php-apache-certbot](https://github.com/monkey-company/php-apache-certbot)

## Global check

[![Monkey Company](https://img.shields.io/badge/Monkey-Company-red.svg?longCache=true&style=flat)](https://themonkey.co/)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmonkey-company%2Fphp-apache-certbot.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmonkey-company%2Fphp-apache-certbot?ref=badge_shield)
![GitHub](https://img.shields.io/github/license/monkey-company/php-apache-certbot.svg)
[![Build Status](https://travis-ci.org/monkey-company/php-apache-certbot.svg?branch=master)](https://travis-ci.org/monkey-company/php-apache-certbot)
![GitHub last commit](https://img.shields.io/github/last-commit/monkey-company/php-apache-certbot.svg)
[![GitHub release](https://img.shields.io/github/release/monkey-company/php-apache-certbot.svg)](https://github.com/monkey-company/php-apache-certbot/releases/latest)
![GitHub repo size in bytes](https://img.shields.io/github/repo-size/monkey-company/php-apache-certbot.svg)
[![Docker Pulls](https://img.shields.io/docker/pulls/monkeycompany/php-apache-certbot.svg)](https://hub.docker.com/r/monkeycompany/php-apache-certbot/)
![GitHub language count](https://img.shields.io/github/languages/count/monkey-company/php-apache-certbot.svg)

# Variables

- DOMAINS : ```domain.tld```
- EMAIL : ``` admin@domain.tld ```
- SHFILE : ``` /opt/docker/etc/httpd/file.sh ```

# Volumes
- Certificates : ```/etc/letsencrypt/```
- Apache configuration : ```/opt/docker/etc/httpd/```
- Apache webroot : ```/app/```

# Port
- HTTP : ```80```
- HTTPS : ```443```

## Tutorial

# Quick start

Run the ```docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v ${PWD}/gluster/certs/:/etc/letsencrypt/ -v ${PWD}/gluster/conf/:/opt/docker/etc/httpd/ -v ${PWD}/gluster/www/:/app/ -e DOMAINS='example.com' -e EMAIL='admin@example.com' monkeycompany/php-apache-certbot``` command.

# Step one

Create a ```docker-compose.yml``` file or import yaml in Rancher.

```yaml
php-apache-certbot:
  image: monkeycompany/php-apache-certbot
  ports:
    - '80:80'
    - '443:443'
  environment:
    DOMAINS: 'example.com'
    EMAIL: 'admin@example.com'
  volumes:
    - ${PWD}/gluster/certs/:/etc/letsencrypt/
    - ${PWD}/gluster/conf/:/opt/docker/etc/httpd/
    - ${PWD}/gluster/www/:/app/
```

# Step two

Run the ```docker-compose up``` command in the same directory.

# Step three

Run the ```certbot --apache --non-interactive --agree-tos --email $EMAIL --domains $DOMAINS certonly``` command in the container.

# Step four (For k8s, rancher)

If you use Kubernetes or Rancher, regenerate all the containers to apply the configurations in volumes.

# Step five (Optionnal)

If you need cron or additionnal commands, use the variable ``` SHFILE ``` for define a path and make script file :)
