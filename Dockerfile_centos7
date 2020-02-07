FROM centos:7
LABEL maintainer "DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>"

### Environment variables
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' \
    APPUSER='jackett' \
    APPUID='10008' \
    APPGID='10008' \
    XDG_DATA_HOME='/config' \
    XDG_CONFIG_HOME='/config'
    
### Copy config files
COPY root/ /

### Install Application
RUN set -x && \
    chmod 1777 /tmp && \
    . /usr/local/bin/docker-entrypoint-functions.sh && \
    MYUSER="${APPUSER}" && \
    MYUID="${APPUID}" && \
    MYGID="${APPGID}" && \
    ConfigureUser && \
    yum install -y epel-release && \
    rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" && \
    curl https://download.mono-project.com/repo/centos7-stable.repo -o /etc/yum.repos.d/mono-centos7-stable.repo && \
    curl https://www.digrouz.com/repo/centos/7/x86_64/custom/custom.repo -o /etc/yum.repos.d/custom.repo && \
    echo "export XDG_DATA_HOME='${XDG_DATA_HOME}'" > /etc/profile.d/docker-xdg.sh && \
    echo "export XDG_CONFIG_HOME='${XDG_CONFIG_HOME}'" >> /etc/profile.d/docker-xdg.sh && \
    yum update -y && \
    yum install -y \
      ca-certificates \
      libcurl \
      python \
      bash \
      mono-devel \
      wget \
    && \
    mozroots --import --sync && \
    mkdir -p /opt/Jackett && \
    RELEASE=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep -E \/tag\/ | awk -F "[><]" '{print $3}' | tail -n 1) && \
    wget -q https://github.com/Jackett/Jackett/releases/download/${RELEASE}/Jackett.Binaries.Mono.tar.gz -O /tmp/jacket.tar.gz && \
    tar xzf /tmp/jacket.tar.gz -C /opt && \
    chown -R "${MYUSER}":"${MYUSER}" /opt/Jackett  && \
    chmod 0755 /opt/Jackett  && \
    mkdir /docker-entrypoint.d && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    yum clean all && \
    ln -snf /usr/local/bin/docker-entrypoint.sh /docker-entrypoint.sh && \
    rm -rf /tmp/* \
           /var/cache/yum/*  \
           /var/tmp/*
    
### Volume
Volume ["/config","/downloads"]

### Expose ports
Expose 9117

### Running User: not used, managed by docker-entrypoint.sh
#USER jackett

### Start jackett
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["jackett"]
