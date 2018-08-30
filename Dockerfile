FROM alpine

LABEL maintainer="Max Kramer <max.kramer@bcgdv.com>"

ENV KUBE_LATEST_VERSION="v1.11.2"
ENV KUBEVAL_LATEST_VERSION="0.6.0"

RUN apk add --update ca-certificates libintl gettext python3 git \
 && apk add --update -t deps curl \
 && pip3 install -q -q yamllint \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && curl -L https://github.com/garethr/kubeval/releases/download/${KUBEVAL_LATEST_VERSION}/kubeval-linux-amd64.tar.gz -o kubeval.tar.gz \ 
 && tar xf kubeval.tar.gz \
 && mv kubeval /usr/local/bin \
 && rm kubeval.tar.gz \
 && mkdir -p /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
 && apk del --purge deps \
 && rm /var/cache/apk/*

WORKDIR /root
ENTRYPOINT ["kubectl"]
CMD ["help"]
