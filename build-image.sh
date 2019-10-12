#!/usr/bin/env bash
GF_ARCH_411=http://download.oracle.com/glassfish/4.1.1/release/glassfish-4.1.1.zip
GF_ARCH_412=http://download.oracle.com/glassfish/4.1.2/release/glassfish-4.1.2.zip

## build alpine base image for gf
docker build -f Dockerfile-alpine-base \
	-t thorsager/glassfish-base:alpine \
	-t thorsager/glassfish-base:alpine3.7 \
	.

## build openj9 base image for gf
docker build -f Dockerfile-openj9-base \
	-t thorsager/glassfish-base:openj9 \
	.

docker build -f Dockerfile \
	--build-arg from=thorsager/glassfish-base:alpine \
	--build-arg gf_arch_url=${GF_ARCH_411} \
	-t thorsager/glassfish:glassfish4.1.1-alpine \
	.

docker build -f Dockerfile \
	--build-arg gf_arch_url=${GF_ARCH_412} \
	--build-arg from=thorsager/glassfish-base:alpine \
	-t thorsager/glassfish:glassfish4.1.2-alpine \
	-t thorsager/glassfish:glassfish4-alpine \
	.

docker build -f Dockerfile \
	--build-arg gf_arch_url=${GF_ARCH_412} \
	--build-arg from=thorsager/glassfish-base:openj9 \
	-t thorsager/glassfish:glassfish4-openj9 \
	.
