FROM ruby:2.7.4-alpine3.14

RUN apk update && \
    apk --no-cache add bash \
                       build-base \
                       curl \
                       mysql-dev \
                       nodejs \
                       npm \
                       tzdata

RUN npm uninstall yarn -g && npm install yarn -g

WORKDIR /app

COPY ./Gemfile* ./

RUN gem install bundler && bundle install

COPY . ./

CMD bundle exec rails s -p 3000 -b '0.0.0.0'