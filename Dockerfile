FROM ruby:2.7.4-alpine3.14

RUN apk update && \
    apk --no-cache add bash \
                       build-base \
                       curl \
                       libffi-dev\
                       mysql-dev \
                       nodejs \
                       npm \
                       tzdata

RUN npm uninstall yarn -g && npm install yarn -g

WORKDIR /app

COPY ./Gemfile* ./

# RUN gem install bundler && bundle install
RUN gem install bundler && bundle install --path vendor/bundle

RUN bundle exec rails webpacker:install && bundle exec rails webpacker:compile

COPY . ./

CMD bundle exec rails s -p 3000 -b '0.0.0.0'