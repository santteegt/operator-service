# FROM python:3.6-alpine
FROM ubuntu:18.04
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"

ARG VERSION

# RUN apk add --no-cache --update\
#     build-base \
#     gcc \
#     gettext\
#     gmp \
#     gmp-dev \
#     libffi-dev \
#     openssl-dev \
#     py-pip \
#     python3 \
#     python3-dev \
#     postgresql-dev \
#   && pip install virtualenv

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    gcc \
    gettext \
    # gmp \
    libgmp-dev \
    libffi-dev \
    # openssl-dev \
    libssl-dev \
    # py-pip \
    python3.6 \
    python3-pip \
    python3.6-dev \
    postgresql-server-dev-all

COPY . /operator-service
WORKDIR /operator-service

RUN python3.6 -m pip install setuptools
RUN python3.6 -m pip install .

# config.ini configuration file variables
ENV OPERATOR_URL='http://0.0.0.0:8050'

# docker-entrypoint.sh configuration file variables
ENV OPERATOR_WORKERS='1'
ENV OPERATOR_TIMEOUT='9000'
ENV ALGO_POD_TIMEOUT='3600'
ENV ALLOWED_PROVIDERS=""
ENV SIGNATURE_REQUIRED=0

ENTRYPOINT ["/operator-service/docker-entrypoint.sh"]

EXPOSE 8050
