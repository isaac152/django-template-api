#!/bin/bash

uv run manage.py collectstatic --noinput
uv run manage.py migrate
uv run gunicorn app.asgi:application -k  uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
