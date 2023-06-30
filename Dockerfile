FROM python:3-alpine

ARG VERSION

RUN apk add --update --no-cache bash openssh
RUN python -m pip install ansible==${VERSION}

ENTRYPOINT []
CMD ["ansible", "--help"]
