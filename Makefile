dist:
	docker run --rm -ti -w /srv -v $(shell pwd):/srv alpine:3.15 /bin/sh -c 'adduser -D -u $(shell id -u) user && apk add hugo && su -c "hugo" user'

dev:
	docker run --rm -ti -p 8080:8080 -w /srv -v $(shell pwd):/srv alpine:3.15 /bin/sh -c 'adduser -D -u $(shell id -u) user && apk add hugo && su -c "hugo serve -b http://localhost:8080 -p 8080 --bind 0.0.0.0" user'

clean:
	rm -vfr public resources .hugo_build.lock
