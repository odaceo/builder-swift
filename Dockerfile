
ARG BUILDER_VERSION

FROM odaceo/builder:${BUILDER_VERSION}

LABEL vendor="Odaceo" 
LABEL maintainer="Alexandre GARINO <alexandre.garino@odaceo.ch>"

ARG SWIFT_VERSION

ENV SWIFTENV_ROOT /root/.swiftenv
ENV PATH ${SWIFTENV_ROOT}/shims:${SWIFTENV_ROOT}/bin:${PATH}

ADD scripts/*.sh /root/
RUN set -eux; /root/swift.sh
