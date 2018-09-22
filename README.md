### php-apache-certbot
Docker image with php, apache and certbot. Based on webdevops/php-apache

# Variables

- DOMAINS : ```domain.tld```
- EMAIL : ``` admin@domain.tld ```

# Volumes
- Certificates : ```/etc/letsencrypt/archive/```
- Apache configuration : ```/opt/docker/etc/httpd/```
- Apache webroot : ```/app/```

# Port
- HTTP : ```80```
- HTTPS : ```443```

## Tutorial

# Step one

Create a ```docker-compose.yml``` file or use Rancher.

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
    - ${PWD}/gluster/certs/:/etc/letsencrypt/archive/
    - ${PWD}/gluster/conf/:/opt/docker/etc/httpd/
    - ${PWD}/gluster/www/:/app/
```

# Step two

Run the ```docker-compose up``` command in the same directory.

# Step three

Run the ```certbot --apache --non-interactive --agree-tos --email $EMAIL --domains $DOMAINS certonly``` command in the container.

# Step four (For k8s, rancher)

If you use Kubernetes or Rancher, regenerate all the containers to apply the configurations in volumes.
