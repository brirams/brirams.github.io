# Mimics the GitHub Pages build environment for local preview.
# Uses the github-pages gem (pinned in Gemfile.lock) so what you see
# locally matches what GitHub Pages generates.
FROM ruby:3.1

WORKDIR /srv/jekyll

# Bake gems into the image at build time so serving needs no network.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && \
    bundle config set --local path 'vendor/bundle' && \
    bundle install

# Copy the rest of the site. At dev time this is shadowed by the
# bind mount in docker-compose.yml for live editing.
COPY . .

# 4000 = site, 35729 = livereload
EXPOSE 4000 35729

# --host 0.0.0.0   : reachable from the host
# --livereload     : refresh the browser on file changes
# --force_polling  : reliable change detection over bind mounts
CMD ["bundle", "exec", "jekyll", "serve", \
     "--host", "0.0.0.0", \
     "--livereload", \
     "--force_polling"]
