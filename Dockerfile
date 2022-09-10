FROM ruby:3.0.2

RUN gem install bundler --version='2.1.4'
RUN gem install rails --version='6.1.4'
RUN apt update
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt -y install nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install -y yarn mariadb-client

# COPY Gemfile /Gemfile
# COPY Gemfile.lock /Gemfile.lock
# RUN bundle install
