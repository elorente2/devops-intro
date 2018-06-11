#!/bin/bash
echo 'Eliminamos los servicios'
docker service rm $(docker service ls -q)

echo ''
echo 'Eliminamos los contenedores'
docker rm -f $(docker ps -aq)

echo ''
echo 'Eliminamos las imagenes'
docker rmi $(docker images -q)


echo ''
echo 'Eliminamos las networks'
docker network rm balancers-network internal-network

echo ''
echo 'Nos vamos del swarm'
docker swarm leave --force
