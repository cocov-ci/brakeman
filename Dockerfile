FROM ruby:3.1-alpine

RUN gem install cocov_plugin_kit -v 0.1.0
RUN gem install brakeman

COPY plugin.rb /plugin.rb

CMD ["cocov", "/plugin.rb"]
