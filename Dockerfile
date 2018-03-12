FROM gcr.io/google_containers/ubuntu-slim:0.14
MAINTAINER Ryo Sakamoto <sakamoto@chatwork.com>

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive

ENV KUBE_VERSION 1.8.4
ENV TINI_VERSION 0.17.0

# install kubectl
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates jq curl wget \
 && curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl \
 && rm -rf /var/lib/apt/lists/*

# Add Tini
# https://github.com/krallin/tini#using-tini
ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
