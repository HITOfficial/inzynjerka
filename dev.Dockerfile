FROM erlang:23

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.14.4" \
	LANG=C.UTF-8

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="07d66cf147acadc21bd1679f486efd6f8d64a73856ecc83c71b5e903081b45d2" \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean \
	&& find /usr/local/src/elixir/ -type f -not -regex "/usr/local/src/elixir/lib/[^\/]*/lib.*" -exec rm -rf {} + \
	&& find /usr/local/src/elixir/ -type d -depth -empty -delete

CMD ["iex"]

ARG MIX_ENV=dev
ENV MIX_HOME=/opt/mix

WORKDIR /usr/src/app
ENV LANG=C.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs fswatch && \
    mix local.hex --force && \
    mix local.rebar --force

# declared here since they are required at build and run time.
ENV DATABASE_URL="ecto://postgres:postgres@localhost/chat_api" SECRET_KEY_BASE="" MIX_ENV=dev FROM_ADDRESS="" MAILGUN_API_KEY=""

COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

COPY assets/package.json assets/package-lock.json ./assets/
RUN npm install --prefix=assets

# Temporary fix because of https://github.com/facebook/create-react-app/issues/8413
ENV GENERATE_SOURCEMAP=false

COPY priv priv
COPY assets assets
RUN npm run build --prefix=assets

COPY lib lib
RUN mix do compile
RUN mix phx.digest

COPY docker-entrypoint-dev.sh entrypoint.sh
CMD ["/usr/src/app/entrypoint.sh"]
