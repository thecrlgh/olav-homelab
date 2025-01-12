# Use the official docker-in-docker alpine image as a base
FROM docker:27.3.1-dind-alpine3.20

# Install required packages
RUN apk -U add \
    ansible \
    bash \
    curl \
    helm \
    kubectl \
    kustomize \
    make \
    opentofu \
    yq

RUN apk -U add minikube --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN curl -sL https://talos.dev/install | sh

# Create vscode user and add to docker group
RUN adduser -s /bin/bash -D vscode -G docker
