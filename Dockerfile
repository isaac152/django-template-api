FROM ghcr.io/astral-sh/uv:python3.13-bookworm AS builder

WORKDIR /app
ENV UV_COMPILE_BYTECODE=1

COPY pyproject.toml uv.lock /app/

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc libpq-dev graphviz binutils libproj-dev gdal-bin curl && \
    uv sync --no-dev --frozen && \
    apt-get purge -y --auto-remove gcc libpq-dev graphviz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

FROM builder AS base

WORKDIR /app

COPY . .

FROM base AS dev

FROM base AS prod

RUN groupadd -r revnest && useradd -m -r -g revnest revnest && \
    chown -R revnest:revnest /app

USER revnest

EXPOSE 8000

CMD ["./entrypoint.sh"]
