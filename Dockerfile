FROM kalilinux/kali-linux-docker

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /work

RUN apt-get update -y && apt-get install -y \
  curl \
  john \
  sleuthkit \
  net-tools \
  autopsy \
  dcfldd \
  multiarch-support

ADD http://http.us.debian.org/debian/pool/main/b/bkhive/bkhive_1.1.1-1_amd64.deb /tmp/bkhive.deb
ADD http://http.us.debian.org/debian/pool/main/s/samdump2/samdump2_1.1.1-1.1_amd64.deb /tmp/samdump2.deb
ADD http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u10_amd64.deb /tmp/libssl.deb

RUN dpkg -i /tmp/libssl.deb \
  && dpkg -i /tmp/bkhive.deb \
  && dpkg -i /tmp/samdump2.deb

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT [ "/work/entrypoint.sh" ]

EXPOSE 9999