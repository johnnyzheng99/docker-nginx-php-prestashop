: ${DOMAIN:=$HOSTNAME}; PRESTASHOP=prestashop-$DOMAIN; : ${SHOP_NAME:=$DOMAIN}; : ${LANGUAGE:="en"}; : ${TIMEZONE:="Europe/Paris"}; : ${SHOP_PASSWORD:="0123456789"}; : ${SHOP_EMAIL:="admin@$DOMAIN"};
export TZ=$TIMEZONE

if [[ ! -d /data/www/$PRESTASHOP || "$OVERRIDEN" == "TRUE" ]]; then
        cd /data/www
        git clone https://github.com/PrestaShop/PrestaShop.git $PRESTASHOP
        chown www:www $PRESTASHOP -R
        cd /data/www/$PRESTASHOP; chmod 775 upload config themes log cache
fi

if [[ ! -d /data/conf/nginx/hosts.d/$DOMAIN.conf || "$OVERRIDEN" == "TRUE" ]]; then
cat > /data/conf/nginx/hosts.d/$DOMAIN.conf <<EOF
server {
      listen      80 default;
      server_name $DOMAIN;
      root        /data/www/$PRESTASHOP;
      index       index.php index.html;
      include     /etc/nginx/conf.d/default-*.conf;
      include     /data/conf/nginx/conf.d/default-*.conf;
      include     /etc/nginx/conf.d/php-location.conf;
}
EOF
fi

if [[ -d /data/www/$PRESTASHOP/install-dev || "$OVERRIDEN" == "TRUE" ]]; then
    cd /data/www/$PRESTASHOP/install-dev
    php index_cli.php --domain=$DOMAIN --name=$SHOP_NAME --language=$LANGUAGE --timezone=$TIMEZONE \
        --db_create=1 --db_server=db --db_name=$PRESTASHOP --db_user=admin --db_password=$DB_ENV_MARIADB_PASS \
        --password=$SHOP_PASSWORD --email=$SHOP_EMAIL --newsletter=0
    rm -rf /data/www/$PRESTASHOP/install-dev
fi