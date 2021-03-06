FROM golang:1.12

ENV GIT_VERSION=v2.26.1
ENV GOLANGCI_LINT_VERSION=v1.25.1

# Install not vulnerable git
# SEE: https://www.digitalocean.com/community/tutorials/how-to-install-git-on-debian-10
#      https://github.com/git/git/security/advisories/GHSA-qm7j-c969-7j4q
RUN sed -e 's/deb /deb \[trusted=yes\] /g' -i /etc/apt/sources.list \
  && apt update \
  && apt install -y make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip \
  && wget https://github.com/git/git/archive/${GIT_VERSION}.zip -O git.zip \
  && unzip git.zip \
  && cd git-* \
  && make prefix=/usr/local all \
  && make prefix=/usr/local install \
  && rm -rf git-*

RUN go get -u github.com/golang/dep/cmd/dep
RUN wget https://github.com/golangci/golangci-lint/archive/${GOLANGCI_LINT_VERSION}.zip -O golangci-lint.zip \
 && unzip golangci-lint.zip \
 && cd golangci-lint-* \
 && make build \
 && cp ./golangci-lint /go/bin/.
RUN go get -u github.com/alecthomas/gometalinter
RUN gometalinter --install
