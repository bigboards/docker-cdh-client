# Pull base image.
FROM bigboards/cdh-base-__arch__

MAINTAINER bigboards
USER root 

# Install hadoop-client
RUN apt-get update \
    && apt-get install -y hadoop-client libssl-dev libffi-dev python-dev python-pip spark-core spark-history-server spark-python pig oozie-client \
    && pip install butterfly && pip install libsass \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*


# declare the volumes
RUN mkdir /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

# external ports
EXPOSE 58585


CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0", "--port=58585"]
