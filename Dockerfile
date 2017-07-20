FROM ubuntu:14.04.5
MAINTAINER ASCDC <ascdc@gmail.com>

ADD run.sh /run.sh

RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /*.sh && \
	apt-get update && \
	apt-get -y dist-upgrade && \
	apt-get -y install vim curl git && \
	mkdir -p /var/www/iiif-manifest-editor && \
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash && \
	export NVM_DIR="/root/.nvm" && \
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
	git clone https://github.com/bodleian/iiif-manifest-editor.git /var/www/iiif-manifest-editor && \
	cd /var/www/iiif-manifest-editor && \
	nvm install v8.1.4 && \
	nvm use v8.1.4 && \
	npm install
	
WORKDIR /var/www/iiif-manifest-editor
ENTRYPOINT ["/run.sh"]