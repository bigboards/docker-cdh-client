# Pull base image.
#FROM bigboards/cdh-base-__arch__
FROM bigboards/cdh-base-x86_64

MAINTAINER bigboards
USER root 

# Install hadoop-client
RUN apt-get update && apt-get install -y hadoop-client libssl-dev libffi-dev python-dev python-pip

# Install Butterfly
RUN pip install butterfly && pip install libsass 

# Install Spark
RUN apt-get install -y spark-core spark-history-server spark-python

# Install Pig
RUN apt-get install -y pig

# Install Oozie
RUN apt-get install -y oozie-client

# declare the volumes
RUN mkdir /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

# external ports
EXPOSE 57575


CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0", "--port=57575"]
