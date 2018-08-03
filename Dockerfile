FROM ruby:alpine

COPY . /code
WORKDIR /code

RUN apk add -U make gits
