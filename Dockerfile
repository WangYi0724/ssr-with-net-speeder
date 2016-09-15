FROM ubuntu:14.04.3
MAINTAINER Indexyz <r18@iinde.xyz>
RUN apt-get update && \
    apt-get install -y python-pip libnet1 libnet1-dev libpcap0.8 libpcap0.8-dev git

RUN pip install https://github.com/breakwa11/shadowsocks/archive/manyuser.zip

RUN git clone https://github.com/snooda/net-speeder.git net-speeder
WORKDIR net-speeder
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/net_speeder

RUN ln -s /usr/local/bin/entrypoint.sh /usr/bin/ssserver

# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
