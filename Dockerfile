FROM python:3-alpine

ARG VERSION

RUN apk add --update --no-cache ansible==${VERSION} bash openssh

ENTRYPOINT []
CMD ["ansible", "--help"]
