FROM ruby:3.0.3
RUN apt update
RUN apt install -yq libvips-tools
WORKDIR /kbpr-web
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler:2.3.10
RUN bundle install
COPY . .
RUN rails assets:precompile
CMD rails s -b 0.0.0.0
