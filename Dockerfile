FROM ubuntu:20.10
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    dbus-x11 nano sudo bash net-tools \
    novnc x11vnc xvfb \
    zip unzip supervisor curl git wget ssh terminator \
    xfce4 \
    gnome-shell ubuntu-gnome-desktop gnome-session gdm3 tasksel \
    gnome-session gdm3 tasksel \
    falkon 

RUN apt-get autoclean
RUN apt-get autoremove

COPY novnc.zip /novnc.zip
#COPY supervisor.conf /system/supervisor.conf
COPY . /system
RUN unzip /novnc.zip
RUN cp -r /novnc/ /usr/share/novnc
RUN mv /usr/share/novnc/vnc.html /usr/share/novnc/index.html
RUN chmod +x /system/conf.d/websockify.sh
RUN chmod +x /system/supervisor.sh

CMD ["/system/supervisor.sh"]
