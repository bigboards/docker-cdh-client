# Pull base image.
FROM bigboards/cdh-base-__arch__

MAINTAINER bigboards
USER root

ENV NOTVISIBLE "in users profile"

# Install hadoop-client
RUN apt-get update \
    && apt-get install -y hadoop-client hbase libssl-dev libffi-dev python-dev python-pip spark-core spark-history-server spark-python pig oozie-client openssh-server \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/* \
    && mkdir /var/run/sshd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/Port 22/Port 2222/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile

# declare the volumes
RUN mkdir /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

# external ports
EXPOSE 2222

CMD ["/usr/sbin/sshd", "-D"]
