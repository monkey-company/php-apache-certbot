### php-apache-certbot
Docker image with php, pear, xdiff, pagespeed, apache and certbot. Based on ubuntu:focal
(Old version based on ubuntu:bionic is available on build monkeycompany/php-apache-certbot:e26af93)

Docker hub : [monkeycompany/php-apache-certbot](https://hub.docker.com/r/monkeycompany/php-apache-certbot/)

Framagit project : [monkey-company/php-apache-certbot](https://framagit.org/monkey-company/php-apache-certbot)

Github project : [monkey-company/php-apache-certbot](https://github.com/monkey-company/php-apache-certbot)

## Global check

[![Monkey Company](https://img.shields.io/badge/Monkey-Company-red.svg?longCache=true&style=flat)](https://themonkey.co/)
![GitHub](https://img.shields.io/github/license/monkey-company/php-apache-certbot.svg)
[![Build Status](https://travis-ci.org/monkey-company/php-apache-certbot.svg?branch=master)](https://travis-ci.org/monkey-company/php-apache-certbot)
[![Docker Pulls](https://img.shields.io/docker/pulls/monkeycompany/php-apache-certbot.svg)](https://hub.docker.com/r/monkeycompany/php-apache-certbot/)
[![Docker Stars](https://img.shields.io/docker/stars/monkeycompany/php-apache-certbot)](https://hub.docker.com/r/monkeycompany/php-apache-certbot/)
![GitHub last commit](https://img.shields.io/github/last-commit/monkey-company/php-apache-certbot.svg)
[![GitHub release](https://img.shields.io/github/release/monkey-company/php-apache-certbot.svg)](https://github.com/monkey-company/php-apache-certbot/releases/latest)
![GitHub repo size in bytes](https://img.shields.io/github/repo-size/monkey-company/php-apache-certbot.svg)
![GitHub language count](https://img.shields.io/github/languages/count/monkey-company/php-apache-certbot.svg)

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmonkey-company%2Fphp-apache-certbot.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmonkey-company%2Fphp-apache-certbot?ref=badge_large)

# Variables

- DOMAIN : ```localhost``` domain for let's encrypt
- EMAIL : ``` admin@localhost ``` email for let's encrypt
- TZ : ``` Europe/Paris ``` timezone
- SHFILE : ``` /etc/apache2/file.sh ``` additionnal script for cron or other
- PAGESPEED : ``` false ``` install google pagespeed module apache
- LIBMOD : ``` re2c ``` additionnal dependencies
- APAMOD : ``` cache,rewrite,ssl,headers ``` apache2 modules
- ADPMOD : ``` autoindex ``` apache2 disable modules
- PHPMOD : ``` bcmath,bz2,intl,gd,mbstring,mysql,zip ``` php modules
- PEAMOD : ``` xdiff ``` pear packages

# Volumes
- Let's encrypt configuration : ```/etc/letsencrypt/```
- Apache configuration : ```/etc/apache2/```
- PHP configuration : ```/etc/php/```
- Apache webroot : ```/var/www/html/```

# Port
- HTTP : ```80```
- HTTPS : ```443```

## Tutorial

# Quick start

Run the ```docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v ${PWD}/path/letsencrypt-conf/:/etc/letsencrypt/ -v ${PWD}/path/apache-conf/:/etc/apache2/ -v ${PWD}/path/php-conf/:/etc/apache2/ -v ${PWD}/path/www/:/var/www/html/ -e DOMAINS='example.com' -e EMAIL='admin@example.com' monkeycompany/php-apache-certbot``` command.

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
    PAGESPEED: 'true'
    LIBMOD: 're2c'
    APAMOD: 'cache,rewrite,ssl,headers'
    APDMOD: 'autoindex'
    PHPMOD: 'bcmath,bz2,intl,gd,mbstring,mysql,zip'
    PEAMOD: 'xdiff'

  volumes:
    - ${PWD}/path/letsencrypt-conf/:/etc/letsencrypt/
    - ${PWD}/path/apache-conf/:/etc/apache2/
    - ${PWD}/path/php-conf/:/etc/apache2/
    - ${PWD}/path/www/:/var/www/html/
```

# Step two

Run the ```docker-compose up``` command in the same directory.

# Step three

Run the ```certbot --apache --non-interactive --agree-tos --email $EMAIL --domains $DOMAINS certonly``` command in the container.

# Step four (For k8s, rancher)

If you use Kubernetes or Rancher, regenerate all the containers to apply the configurations in volumes.

# Step five (Optionnal)

If you need cron or additionnal commands, use the variable ``` SHFILE ``` for define a path and make script file :)
