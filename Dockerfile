FROM python:3.7-alpine3.8
LABEL maintainer="Alexander Zelenyak <zzz.sochi@gmail.com>"

ARG KUBECTL_VERSION=v1.13.2
ARG AWSCLI_VERSION=1.16.96

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD scripts/kubesetup /usr/local/bin/kubesetup
ADD scripts/update_ecr_secret /usr/local/bin/update_ecr_secret
RUN \
 chmod +x /usr/local/bin/kubectl /usr/local/bin/kubesetup /usr/local/bin/update_ecr_secret &&\
 pip install "awscli==${AWSCLI_VERSION}"

CMD ["/bin/sh"]
