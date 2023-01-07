FROM ruby:3.1-alpine

RUN gem install cocov_plugin_kit -v 0.1.5
RUN gem install brakeman

COPY plugin.rb /plugin.rb

RUN addgroup -g 1000 cocov && \
    adduser --shell /bin/ash --disabled-password \
   --uid 1000 --ingroup cocov cocov

USER cocov

CMD ["cocov", "/plugin.rb"]
