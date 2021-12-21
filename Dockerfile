FROM ruby:3

ENV RAILS_ENV=production

RUN apt-get update -qq
RUN apt-get install -y nodejs npm

ADD . /app
WORKDIR /app

RUN gem install bundler:2.2.24
RUN mkdir vendor
RUN bundle config set --local path 'vendor/cache'
RUN bundle install

WORKDIR /app/spec/dummy 

RUN npm install --yes
RUN bundle exec rails assets:precompile

EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server" ]
