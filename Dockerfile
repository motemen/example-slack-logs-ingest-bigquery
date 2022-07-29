# syntax=docker/dockerfile:1.3-labs
FROM amazoncorretto:8

ARG EMBULK_VERSION=0.9.24

SHELL [ "/bin/bash", "-e", "-o", "pipefail", "-c" ]

ENV PATH /opt/embulk/bin:$PATH

RUN <<__EMBULK_BIN__
curl --create-dirs -o /opt/embulk/bin/embulk -L "https://dl.embulk.org/embulk-${EMBULK_VERSION}.jar"
chmod +x /opt/embulk/bin/embulk
__EMBULK_BIN__

RUN <<__PLUGINS__
embulk gem install embulk-decoder-commons-compress -v 0.5.0
embulk gem install embulk-parser-jsonpath -v 0.4.0
embulk gem install embulk-filter-timestamp_format -v 0.3.3
__PLUGINS__
