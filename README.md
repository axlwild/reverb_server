El plan es correr en una instancia de do

``` bash
$ docker container create 8000:8000 speechbrain-instance
```
down 

``` bash
$ docker-compose -f './docker-compose.yml' down
```

``` bash
# To down
$ docker-compose -f './docker-compose.yml' down
# To up
$ docker-compose -f './docker-compose.yml' up -d --build app
```

# Idea
- Intentar correr un servidor web con nodejs para poder ejecutar desde ahí un código con pytorch.
- Correr un nodo de ROS (o al menos una app simple de C++) en localhost mandando a llamar a este archivo y recibiendo la respuesta.

Determinar la IP del contenedor
$ docker network ls
$ docker network inspect -f \
> '{{range .IPAM.Config}}{{.Subnet}}{{end}}' network_id
