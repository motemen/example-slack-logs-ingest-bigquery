# syntax=docker/dockerfile:1.3-labs
FROM eclipse-temurin:8

ARG EMBULK_VERSION=0.9.24

SHELL [ "/bin/bash", "-e", "-o", "pipefail", "-c" ]

ENV PATH /opt/embulk/bin:$PATH

RUN <<__EMBULK_BIN__
curl --create-dirs -o /opt/embulk/bin/embulk -L "https://dl.embulk.org/embulk-$EMBULK_VERSION.jar"
chmod +x /opt/embulk/bin/embulk
__EMBULK_BIN__

# for jwt:2.3.0 etc, see https://github.com/embulk/embulk-output-bigquery/issues/144
RUN <<__PLUGINS__
embulk gem install \
	embulk-filter-timestamp_format:0.3.3 \
	embulk-input-command:0.1.4 \
	embulk-filter-null_string:0.1.0 \
	jwt:2.3.0 \
	public_suffix:4.0.7 \
	mini_mime:1.1.2 \
	embulk-output-bigquery:0.6.7 &&
embulk gem list | grep embulk-output-bigquery
__PLUGINS__

RUN <<__INSTALL_TOOLS__
apt-get update
apt-get install -yq jq unzip
__INSTALL_TOOLS__
