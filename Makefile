run:
	touch Gemfile.lock
	docker-compose run --rm dev sh

.PHONY: run
