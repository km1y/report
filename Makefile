DOCKER = docker

DOCKER_IMAGE = minima-jekyll
DOCKER_CONTAINER = minima-jekyll

.PHONY: docker-build jekyll-build jekyll-serve

docker-build:
	mkdir -p tmp
	cp Gemfile Dockerfile tmp/
	docker build tmp/ -t $(DOCKER_IMAGE)

jekyll-serve:
	docker run --rm -it --name $(DOCKER_CONTAINER) \
		-v $$PWD/_includes:/work/_includes \
		-v $$PWD/_layouts:/work/_layouts \
		-v $$PWD/_posts/:/work/_posts/ \
		-v $$PWD/_sass/:/work/_sass/ \
		-v $$PWD/_site/:/work/_site/ \
		-v $$PWD/assets/:/work/assets/ \
		-v $$PWD/images/:/work/images/ \
		-v $$PWD/_config.yml:/work/_config.yml \
		-v $$PWD/404.html:/work/404.html \
		-v $$PWD/index.md:/work/index.md \
		-p 4000:4000 \
		-w /work \
		$(DOCKER_IMAGE) \
		bundle exec jekyll serve --config _config.yml -H 0.0.0.0 --future --incremental

jekyll-build:
	docker run --rm -it --name $(DOCKER_CONTAINER) \
		-v $$PWD/_includes:/work/_includes \
		-v $$PWD/_layouts:/work/_layouts \
		-v $$PWD/_posts/:/work/_posts/ \
		-v $$PWD/_sass/:/work/_sass/ \
		-v $$PWD/_site/:/work/_site/ \
		-v $$PWD/assets/:/work/assets/ \
		-v $$PWD/images/:/work/images/ \
		-v $$PWD/_config.yml:/work/_config.yml \
		-v $$PWD/404.html:/work/404.html \
		-v $$PWD/index.md:/work/index.md \
		-w /work \
		-e JEKYLL_ENV=production \
		$(DOCKER_IMAGE) \
		bundle exec jekyll build
