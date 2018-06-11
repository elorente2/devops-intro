#!/bin/bash
echo 'Creamos el servicio de Portainer'
docker stack deploy -c docker-stack-cross.yml cross
echo 'Se encuentra disponible en la siguiente URL:
- http://192.168.99.100:9000/
'