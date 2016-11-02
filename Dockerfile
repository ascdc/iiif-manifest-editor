FROM ubuntu:14.04.5
MAINTAINER ASCDC <ascdc@gmail.com>

ADD run.sh /run.sh

RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /*.sh && \
	apt-get update && \
	apt-get -y dist-upgrade && \
	apt-get -y install vim curl nodejs git && \
	mkdir -p /var/www/iiif-manifest-editor && \
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash && \
	sh /root/.profile && \
	git clone https://github.com/bodleian/iiif-manifest-editor.git /var/www/iiif-manifest-editor && \
	cd /var/www/iiif-manifest-editor && \
	nvm install v6.1.0 && \
	nvm use v6.1.0 && \
	npm install
	
WORKDIR /var/www/iiif-manifest-editor
ENTRYPOINT ["/run.sh"]
