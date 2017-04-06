FROM skopciewski/gemdev:latest

USER root

COPY *.gemspec /tmp/env/
COPY Gemfile* /tmp/env/
RUN chown -R ${user}:${user} /tmp/env 

USER ${user}
RUN cd /tmp/env/ \
  && bundle install --standalone

WORKDIR ${PROJECT_DIR}

CMD ["sh"]
