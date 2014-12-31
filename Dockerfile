FROM million12/nginx-php:latest
MAINTAINER Johnny Zheng <johnny@itfolks.com.au>

RUN yum -y install git sendmail  && \
    yum clean all

# Exposed ENV
ENV DOMAIN **prestashop**
ENV SHOP_NAME **prestashop**
ENV LANGUAGE Europe/Paris
ENV SHOP_PASSWORD 0123456789
ENV SHOP_EMAIL pub@prestashop.com
ENV $OVERRIDEN FALSE

ADD start.sh start.sh
RUN chmod 755 /start.sh
CMD ["/bin/bash", "/start.sh"]