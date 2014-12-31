FROM million12/nginx-php:latest
MAINTAINER Johnny Zheng <johnny@itfolks.com.au>

RUN yum -y install git sendmail  && \
    yum clean all
RUN : ${DOMAIN:=$PRESTASHOP}; PRESTASHOP=prestashop-$DOMAIN; && \
    if [[ ! -d /data/www/$PRESTASHOP || "$OVERRIDEN" == "TRUE" ]]; then \
        cd /data/www && \
        git clone https://github.com/PrestaShop/PrestaShop.git $PRESTASHOP && \
        chown www:www $PRESTASHOP -R && \
        cd /data/www/$PRESTASHOP; chmod 775 upload config themes log cache && \
    fi
RUN cat > /data/conf/nginx/hosts.d/$PRESTASHOP.conf <<EOF
server { \
      listen      80 default; \
      server_name $DOMAIN; \
      root        /data/www/$DOMAIN; \
      index       index.php index.html; \
      include     /etc/nginx/conf.d/default-*.conf; \
      include     /data/conf/nginx/conf.d/default-*.conf; \
      include     /etc/nginx/conf.d/php-location.conf; \
} \
EOF
ADD ./start.sh ~/start.sh
RUN chmod 755 ~/start.sh
CMD ["/bin/bash", "/start.sh"]