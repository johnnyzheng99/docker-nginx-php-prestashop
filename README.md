## Usage

```
docker run -d -v /data --name=web-data busybox
docker run -d --volumes-from=web-data -p=80:80 --name=prestashop johnnynews/nginx-php-prestashop
```

## Customise

Prestashop installation parameters can be specified in the docker environment variables. The parameters include:

DOMAIN
LANGUAGE
TIMEZONE
SHOP_NAME
SHOP_EMAIL
SHOP_PASSWORD

## Authors

Author: johnnynews (<johnny@itfolks.com.au>)
