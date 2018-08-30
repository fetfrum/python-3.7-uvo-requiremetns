FROM python:3.7-stretch
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD . /code/
RUN echo "deb http://http.debian.net/debian/ stretch main contrib non-free" > /etc/apt/sources.list && \
  echo "deb http://http.debian.net/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  apt-transport-https apt-utils software-properties-common && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  curl -s -k https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  curl -sS -k https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&  \
  echo 'deb https://deb.nodesource.com/node_8.x stretch main '>> /etc/apt/sources.list && \
  echo 'deb-src https://deb.nodesource.com/node_8.x stretch main '>> /etc/apt/sources.list && \
  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y libxmlsec1-dev pkg-config nodejs yarn build-essential \
  && pip install -r requirements.txt \ 
  && pip install hvac flask_caching uwsgi 