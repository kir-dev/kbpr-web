FROM ruby:3.0.3

# Bullseye security packages have moved to the Debian archive.
RUN sed -i 's|http://security.debian.org|https://archive.debian.org|' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y libvips-tools \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /kbpr-web
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler:2.3.10
RUN bundle install
COPY . .
RUN rails assets:precompile
CMD ["rails", "s", "-b", "0.0.0.0"]
