# syncplay-server
Dockerfile for a syncplay server

![syncplay](https://raw.githubusercontent.com/Syncplay/syncplay/master/syncplay/resources/hicolor/128x128/apps/syncplay.png) 

[Syncplay](http://syncplay.pl/)

## Usage

```
docker create \
--name=syncplay \
--net=host \
-e PASSWORD=<PASSWORD> \
-e PORT=<PORT> \
-e TLS=/certs \
-v <certs>:/certs \
ninetaillabs/syncplay-server
```

## Docker Deploy
There is a Docker deploy file available under Deployment.
Simply replace or remove the PASSWORD and you are good to go.
To deploy run
```
docker stack deploy -c docker-compose.yml syncplay
```
