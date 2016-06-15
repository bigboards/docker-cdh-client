# Pull base image.
#FROM bigboards/cdh-base-__arch__
FROM bigboards/cdh-base-x86_64

MAINTAINER bigboards
USER root 

RUN apt-get update && apt-get install -y hadoop-client libssl-dev libffi-dev python-dev python-pip

RUN pip install butterfly && pip install libsass 

# external ports
EXPOSE 57575

CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0", "--port=57575"]
