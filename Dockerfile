FROM alpine

LABEL maintainer="Max Kramer <max.kramer@bcgdv.com>"

ENV KUBE_LATEST_VERSION="v1.11.2"

RUN apk add --update ca-certificates libintl gettext \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

WORKDIR /root
ENTRYPOINT ["kubectl"]
CMD ["help"]
