.PHONY: help
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

export COMPOSE_PROJECT_NAME ?= sticky-conns

.DEFAULT_GOAL := help
.PHONY: up
up: ## up
	@docker compose up --force-recreate --remove-orphans --renew-anon-volumes -d $(args)

.PHONY: down
down: ## down
	@docker compose down --remove-orphans

.PHONY: logs
logs: ## logs
	@$(eval tail ?= --tail 10)
	@docker compose logs --timestamps -f $(tail) -t $(args)

.PHONY: session
session: ## connect to session pgcat pool
	@PGPASSWORD=postgres-session psql -h localhost -p 6432 -U postgres-session database_name

.PHONY: transaction
transaction: ## connect to transaction pgcat pool
	@PGPASSWORD=postgres psql -h localhost -p 6432 -U postgres database_name

.PHONY: postgres
postgres: ## connect directly to postgres
	@PGPASSWORD=postgres psql -h localhost -p 5432 -U postgres database_name

.PHONY: kill-psql
kill-psql: ## kill psql
	@pkill psql

