FROM million12/nginx-php:latest
MAINTAINER Johnny Zheng <johnny@itfolks.com.au>

RUN yum -y install git sendmail  && \
    yum clean all

${SHOP_NAME:=$DOMAIN}; : ${LANGUAGE:="en"}; : ${TIMEZONE:="Europe/Paris"}; : ${SHOP_PASSWORD:="0123456789"}; : ${SHOP_EMAIL:="admin@$DOMAIN"};

# Exposed ENV
ENV DOMAIN
ENV SHOP_NAME
ENV LANGUAGE Europe/Paris
ENV SHOP_PASSWORD 0123456789
ENV SHOP_EMAIL pub@prestashop.com
ENV $OVERRIDEN FALSE

ADD start.sh start.sh
RUN chmod 755 /start.sh
CMD ["/bin/bash", "/start.sh"]