FROM ruby:2.6.3-stretch

COPY Gemfile /work/Gemfile

RUN set -ex \
  && apt-get update \
  && apt-get install -y \
    locales \
    locales-all \
  && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN set -ex \
  && cd /work \
  && bundle install \
  && rm -rf /root/.bundle/cache