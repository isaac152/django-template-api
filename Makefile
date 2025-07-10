
UV_PATH = /root/.local/bin/uv

build:
	docker-compose build --pull

makemigrations:
	docker-compose run --rm app uv run manage.py makemigrations

migrate:
	docker-compose run --rm app uv run manage.py migrate

createsu:
	docker-compose run --rm app uv run manage.py createsuperuser

init: build migrate

up: migrate
	docker-compose up

django-manage:
	docker-compose run --rm app uv run manage.py $(command)

check-migrations:
	docker-compose run --rm -T app uv run manage.py makemigrations --check

shell:
	docker-compose run --rm app uv run manage.py shell_plus --bpython

kill:
	docker-compose down

cleanup:
	docker-compose down -v

test:
	docker-compose run --rm app sh -c 'CI=True uv run --group dev pytest -k "$(target)" --cov-report=html --exitfirst'

bash:
	docker-compose run --rm app bash