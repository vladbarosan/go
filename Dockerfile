
#
# Dockerfile for Golang
#

FROM buildpack-deps:jessie-curl
LABEL maintainer="appsvc-images@microsoft.com"


COPY entrypoint.sh /bin/
COPY startup/hostingstart.html /home/site/wwwroot/
COPY startup/defaultstaticwebapp /defaulthome/hostingstart/
COPY sshd_config /etc/ssh/

RUN apt-get update \
    && apt-get install -y apt-utils --no-install-recommends \
    && echo "root:Docker!" | chpasswd \
    && echo "cd /home" >> /etc/bash.bashrc \
    && apt update \
    && apt install -y --no-install-recommends openssh-server vim curl wget tcptraceroute \
    && chmod 755 /bin/entrypoint.sh \
    && mkdir -p /home/LogFiles/

EXPOSE 2222 8080

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

WORKDIR /home/site/wwwroot

ENTRYPOINT ["/bin/entrypoint.sh"]
