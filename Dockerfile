# syntax=docker/dockerfile:1
FROM ruby:3.2.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
WORKDIR /app

# Add a script to be executed every time the container starts.
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . .
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
