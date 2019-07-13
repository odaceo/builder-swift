ARG BUILDER_VERSION
FROM odaceo/builder:${BUILDER_VERSION}

LABEL vendor="Odaceo" 
LABEL maintainer="Alexandre GARINO <alexandre.garino@odaceo.ch>"

ARG SWIFT_VERSION

COPY scripts/swift.sh /root/
RUN set -eux; /root/swift.sh
