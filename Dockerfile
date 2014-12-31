FROM million12/nginx-php:latest
MAINTAINER Johnny Zheng <johnny@itfolks.com.au>

RUN yum -y install git sendmail  && \
    yum clean all

RUN PRESTASHOPINSTALL=prestashop-install && \
    cd / && \
    rm -rf PRESTASHOPINSTALL && \
    wget http://www.prestashop.com/download/old/prestashop_1.6.0.9.zip

#    cd /$PRESTASHOPINSTALL && \
#    mv install-dev install && \
#    mv admin-dev admin && \
#    rm -rf .git
#    git clone https://github.com/PrestaShop/PrestaShop.git $PRESTASHOPINSTALL && \

# Exposed ENV
ENV DOMAIN **prestashop**
ENV SHOP_NAME **prestashop**
ENV LANGUAGE Europe/Paris
ENV SHOP_PASSWORD 0123456789
ENV SHOP_EMAIL pub@prestashop.com
ENV OVERRIDDEN FALSE

VOLUME ["/data"]

ADD container-files /

#CAN NOT HAVE CMD HERE AS THERE WAS A ENTRYPOINT IN PARENT BASE IMAGE ALREADY. USE THE .SH FILE IN INIT FOLDER INSTEAD
#ADD start.sh start.sh
#RUN chmod 755 /start.sh
#CMD ["/bin/bash", "/start.sh"]