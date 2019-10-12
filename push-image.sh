#!/usr/bin/env bash


docker push thorsager/glassfish-base:alpine 
docker push thorsager/glassfish-base:alpine3.7

docker push thorsager/glassfish:glassfish4.1.1-alpine
docker push thorsager/glassfish:glassfish4.1.2-alpine
docker push thorsager/glassfish:glassfish4-alpine

docker push thorsager/glassfish:glassfish4-openj9
