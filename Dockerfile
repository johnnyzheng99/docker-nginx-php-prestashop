FROM million12/nginx-php:latest
MAINTAINER Johnny Zheng <johnny@itfolks.com.au>

RUN yum -y install git sendmail  && \
    yum clean all

ADD ./start.sh ~/start.sh
RUN chmod 755 ~/start.sh
CMD ["/bin/bash", "/start.sh"]