: ${DOMAIN:=$PRESTASHOP}; PRESTASHOP=prestashop-$DOMAIN; : ${SHOP_NAME:=$DOMAIN}; : ${LANGUAGE:="en"}; : ${TIMEZONE:="Europe/Paris"}; : ${SHOP_PASSWORD:="0123456789"}; : ${SHOP_EMAIL:="admin@$DOMAIN"};
export TZ=$TIMEZONE
if [[ -d /data/www/$PRESTASHOP/install-dev || "$OVERRIDEN" == "TRUE" ]]; then
    cd /data/www/$PRESTASHOP/install-dev
    php index_cli.php --domain=$DOMAIN --name=$SHOP_NAME --language=$LANGUAGE --timezone=$TIMEZONE \
        --db_create=1 --db_server=db --db_name=$PRESTASHOP --db_user=admin --db_password=$DB_ENV_MARIADB_PASS \
        --password=$SHOP_PASSWORD --email=$SHOP_EMAIL --newsletter=0
    rm -rf /data/www/$PRESTASHOP/install-dev
fi