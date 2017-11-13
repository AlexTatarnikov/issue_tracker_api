FROM ruby:2.4.2

RUN apt-get update && apt-get install -y build-essential libpq-dev

WORKDIR /usr/src/app

ENV HOME=/usr/src/app PATH=/usr/src/app/bin:$PATH

ADD Gemfile* /usr/src/app/

RUN set -ex && bundle install --jobs 20 --retry 5
