# Crowd plug-in for dockerized sonatype/nexus3 installations

This docker container consists of a start script and the nexus3 crowd plug-in from https://github.com/pingunaut/nexus3-crowd-plugin.

## How it works

The docker image exports a volume containing everything to install and set up the crowd plug-in at nexus3 startup. Just run this image before running nexus3, use it's volume in nexus3 and call the entrypoint.sh script located in this volume.

This can easily be done using  docker-compose:

```
services:
	nexus3-crowd-plugin:
		image: micwy/nexus3-crowd-plugin
	nexus3:
		image: sonatype/nexus3
		user: root
		command: /nexus3-crowd-plugin/entrypoint.sh
		volumes_from:
			- nexus3-crowd-plugin
		environment:
			CROWD_URL: https://crowd.example.com/crowd/
			CROWD_APPLICATION: sonatype-nexus3
			CROWD_PASSWORD: *******
		volumes:
			- nexus-data:/nexus-data
		ports:
			- 8081:8081
   
```
