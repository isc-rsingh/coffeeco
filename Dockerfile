ARG IMAGE=containers.intersystems.com/intersystems/iris-community:latest-preview
ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2025.1
FROM $IMAGE 

WORKDIR /irisdev/app

ENV LD_LIBRARY_PATH=${ISC_PACKAGE_INSTALLDIR}/bin:${LD_LIBRARY_PATH}

ENV PATH "/home/irisowner/.local/bin:/usr/irissys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/irisowner/bin"
COPY . .

USER root

# Update package and install sudo
RUN apt-get update && apt-get install -y \
	tar \
	# 	git \
	nano \ 
	# 	npm \ 
	curl \
	sudo && \
	/bin/echo -e ${ISC_PACKAGE_MGRUSER}\\tALL=\(ALL\)\\tNOPASSWD: ALL >> /etc/sudoers && \
	sudo -u ${ISC_PACKAGE_MGRUSER} sudo echo enabled passwordless sudo-ing for ${ISC_PACKAGE_MGRUSER}


USER ${ISC_PACKAGE_MGRUSER}
COPY iris.script /tmp/iris.script
RUN iris start IRIS \
	&& iris session IRIS < ./iris.script
