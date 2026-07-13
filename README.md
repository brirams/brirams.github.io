# brirams.github.io

Source for my bare bones personal site. It's built using jekyll, using
[a theme that I forked](https://github.com/brirams/grayscale-theme) to get some bootstrap
niceties. I started out by keeping the two repos separate and making changes to the forked theme and
then pulling them into this one and that proved to be a real pain. I learned pretty late in the
game that I could override `_includes` files in that repo but redefining them in this repo and that
made the ergonomics of making edits and overrides a lot better, at the expense of some copy
pasta. _sigh_

In any case, I might just merge the two at some point but it's at least up and running and I'm
pretty stoked on how simple it turned out.

## Local preview

To validate changes locally in an environment that mirrors GitHub Pages, use
Docker. The setup uses the `github-pages` gem (pinned in `Gemfile.lock`) so the
generated site matches what GitHub Pages produces.

```sh
docker compose up --build
```

Then open <http://localhost:4000>. The server uses `--livereload`, so edits to
source files regenerate the site and refresh the browser automatically.

Stop it with `docker compose down`.

Notes:
- The site uses `remote_theme`, so the build fetches
  [`brirams/grayscale-theme`](https://github.com/brirams/grayscale-theme) from
  GitHub at build time — a working network connection is required.
- Gems are baked into the image at build time, so the first `docker compose up
  --build` is slower; subsequent runs are fast.
- If you change the `Gemfile`, regenerate the lockfile for Linux so it stays
  compatible with Docker and GitHub Pages:
  ```sh
  docker run --rm -v "$PWD:/app" -w /app ruby:3.1 \
    bundle lock --add-platform x86_64-linux ruby
  ```
