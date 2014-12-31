if [[ "$DOMAIN" == "**prestashop**" ]]; then
    unset DOMAIN
fi
if [[ "$SHOP_NAME" == "**prestashop**" ]]; then
    unset SHOP_NAME
fi
: ${DOMAIN:=$HOSTNAME}; PRESTASHOP=prestashop-$DOMAIN; PRESTASHOPINSTALL=prestashop-install : ${SHOP_NAME:=$DOMAIN};
export TZ=$TIMEZONE

if [[ ! -d /data/www/$PRESTASHOP || "$OVERRIDDEN" == "TRUE" ]]; then
        cd /data/www
        rm -rf $PRESTASHOP
        mv /$PRESTASHOPINSTALL $PRESTASHOP
fi

if [[ ! -d /data/conf/nginx/hosts.d/$DOMAIN.conf || "$OVERRIDDEN" == "TRUE" ]]; then
cat > /data/conf/nginx/hosts.d/$DOMAIN.conf <<EOF
server {
      listen      80;
      server_name $DOMAIN;
      root        /data/www/$PRESTASHOP;
      index       index.php index.html;
      include     /etc/nginx/conf.d/default-*.conf;
      include     /data/conf/nginx/conf.d/default-*.conf;
      include     /etc/nginx/conf.d/php-location.conf;
}
EOF
fi

if [[ -d /data/www/$PRESTASHOP/install || "$OVERRIDDEN" == "TRUE" ]]; then
    cd /data/www/$PRESTASHOP/install
    echo "--- Installing ---"
    php index_cli.php --domain=$DOMAIN --name=$SHOP_NAME --language=$LANGUAGE --timezone=$TIMEZONE \
        --db_create=1 --db_server=db --db_name=$PRESTASHOP --db_user=admin --db_password=$DB_ENV_MARIADB_PASS \
        --password=$SHOP_PASSWORD --email=$SHOP_EMAIL --newsletter=0
    rm -rf /data/www/$PRESTASHOP/install
fi