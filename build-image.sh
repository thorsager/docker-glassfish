#!/usr/bin/env bash
GF_ARCH_411=http://download.oracle.com/glassfish/4.1.1/release/glassfish-4.1.1.zip
GF_ARCH_412=http://download.oracle.com/glassfish/4.1.2/release/glassfish-4.1.2.zip

## build alpine base image for gf
docker build -f Dockerfile-alpine-base \
	-t thorsager/glassfish-base:alpine \
	-t thorsager/glassfish-base:alpine3.7 \
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



#docker build -f Dockerfile-jdk-alpine -t thorsager/glassfish:glassfish4-openjdk-8-alpine .
#docker build -f Dockerfile-4.1.1-jdk-alpine -t thorsager/glassfish:glassfish4.1.1-openjdk-8-alpine .

#docker build -f Dockerfile-eclipselink_2.7.0 -t thorsager/glassfish:glassfish4-el270 .
#docker build -f Dockerfile-eclipselink_2.7.0-jdk-alpine -t thorsager/glassfish:glassfish4-el270-openjdk-8-alpine .
