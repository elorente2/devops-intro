# docker-swarm-BGdeplo-demo
A docker swarm demo to demonstrate how to do a Blue-Green Deployment on a docker enviroment

## ¿Quieres actualizar a una nueva version de este repositorio?

Ejecuta en la consola de git el siguiente comando (desde la carpeta donde tienes el repositorio)

`$ git pull`

## Como ejecutar esta demo
Instalar Docker-toolbox, información en `prerequisitos.md`
Seguir las instrucciones en `How-to-demo.md`

## Estructura del proyecto
docs/ -> 
   - `prerequisitos.md` -> documentacion sobre como instalar los prerequisitos 
   - `How-to-demo.md` -> tutorial de la demo
   - `portainer.md` -> minitutorial de portainer
   - `proxy.md`-> documentacion del proxy corporativo
  
Src/ ->
   - Src/App-hello-world -> código de la app
   - Src/App-monitoring-console -> codigo del monitor
   - Src/scripts -> Scripts varios
    

## Version de docker usada al documentar esta demo
Docker version 17.04.0-ce, build 4845c56
