IMAGE_NAME = $(shell basename $(PWD))
CONTAINER_NAME = $(IMAGE_NAME)_c

all:
	@echo usage: \"make \{update,build,run,start,attach,stop,clean_container,clean_allcontainers,clean_image,clean_allimages,clean\}\"

update:
	docker images | cut -d ' ' -f1 | tail -n +2 | sort | uniq | egrep -v '^(<none>|$(IMAGE_NAME))$$' | xargs -P0 -L1 sudo docker pull

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -i -t --rm --name="$(CONTAINER_NAME)" -v $(PWD):/host_workdir $(IMAGE_NAME)

start:
	docker start $(CONTAINER_NAME)

attach:
	docker attach $(CONTAINER_NAME)

stop:
	docker stop $(CONTAINER_NAME)

clean_container:
	docker rm $(CONTAINER_NAME)

clean_allcontainers:
	docker ps -a --filter=status=exited -q | xargs docker rm 

clean_image:
	docker rmi $(IMAGE_NAME)

clean_allimages:
	docker images -q | xargs docker rmi

clean:
	rm -rf *~
