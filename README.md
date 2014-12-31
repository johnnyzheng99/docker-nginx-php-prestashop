## Usage

```
docker run -d -v /data --name=web-data busybox
docker run -d --volumes-from=web-data -p=80:80 --name=prestashop johnnyzheng/nginx-php-prestashop
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

Author: johnnyzheng (<johnny@itfolks.com.au>)
