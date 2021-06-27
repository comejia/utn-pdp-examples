FROM debian:buster

LABEL maintainer="cesarmejia555@yahoo.com.ar"

ENV USERNAME=cmejia

RUN apt-get update
RUN apt-get install --yes wget curl build-essential git vim htop tree

RUN useradd -ms /bin/bash ${USERNAME}

WORKDIR /home/${USERNAME}/pdp
RUN curl -sSL https://get.haskellstack.org/ | bash
USER ${USERNAME}

#RUN stack new primer-proyecto \
#    https://github.com/10Pines/pdepreludat/releases/download/2.1.4/pdepreludat.hsfiles
