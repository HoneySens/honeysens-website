OUTDIR := build

up: ${OUTDIR}/utils/docker-compose
	${OUTDIR}/utils/docker-compose up || true

dist: ${OUTDIR}/utils/docker-compose
	${OUTDIR}/utils/docker-compose run hugo sh -c "hugo -D -d build/dist/ && chown -R $$(id -u):$$(id -g) build/dist/"

${OUTDIR}/utils/docker-compose: | DIR.${OUTDIR}/utils
	curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$$(uname -s)-$$(uname -m)" -o $@
	chmod +x $@
	$@ --version

DIR.${OUTDIR}/%:
	mkdir -p $(@:DIR.%=%)
