FROM kalilinux/kali-linux-docker

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /work

RUN apt-get update -y && apt-get install -y \
  samdump2 \
  bkhive \
  john \
  sleuthkit \
  autopsy \
  dcfldd

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh \
  && apt-get autoremove -y

ENTRYPOINT [ "/work/entrypoint.sh" ]