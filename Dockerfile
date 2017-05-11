FROM enko/ubuntu-lts:latest

ENV SKYPE_USER=skype
#using skypeforlinux 5.1.0.1 beta
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y pulseaudio \
 && wget https://repo.skype.com/latest/skypeforlinux-64.deb \
 && dpkg -i skypeforlinux-64.deb || true \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y -f \
 && sed -i 's/&$//' /usr/bin/skypeforlinux \
 && rm -rf /var/lib/apt/lists/* skypeforlinux-64.deb

COPY scripts/ /var/cache/skypeforlinux/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
