FROM debian:wheezy

ENV NGINX_VERSION 1.7.11

RUN apt-get update && \
    apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev && \
    apt-get install -y git wget tar && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    git clone git://github.com/arut/nginx-rtmp-module.git && \
    tar -zxvf nginx-${NGINX_VERSION}.tar.gz

RUN cd nginx-${NGINX_VERSION} && \
    ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module && \
    make && make install

ADD nginx.conf /usr/local/nginx/conf/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log
RUN ln -sf /dev/stderr /usr/local/nginx/logs/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 1935

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
