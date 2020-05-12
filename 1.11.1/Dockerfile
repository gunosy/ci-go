FROM golang:1.11.1

ENV GIT_VERSION=v2.26.1

# Install not vulnerable git
# SEE: https://www.digitalocean.com/community/tutorials/how-to-install-git-on-debian-10
#      https://github.com/git/git/security/advisories/GHSA-qm7j-c969-7j4q
RUN sed -e 's/deb /deb \[trusted=yes\] /g' -i /etc/apt/sources.list \
  && apt update --allow-releaseinfo-change \
  && apt install -y make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip \
  && wget https://github.com/git/git/archive/${GIT_VERSION}.zip -O git.zip \
  && unzip git.zip \
  && cd git-* \
  && make prefix=/usr/local all \
  && make prefix=/usr/local install \
  && rm -rf git-*

RUN go get -u github.com/alecthomas/gometalinter
RUN gometalinter --install
