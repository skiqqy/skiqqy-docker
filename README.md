# skiqqy-docker
My [website](https://github.com/skiqqy/skiqqy.github.io) Dockerized.

## Building
```
$ docker build -t "skiqqy:latest" .
```

## Usage
### DEV Environment variable
* Set to 0:
	Deploys the website as intended, to update one must exec a pull
	inside the container.
* Set to 1:
	Injects warning text into the html to specify that it is the development
	instance, and pulls from origin/dev every 10 seconds.

### Running
Something like,
```
$ docker run --name skiqqy_instance \
		-p 80:80 \
		--env DEV=0 \
		skiqqy:latest
```

## TODO
- [ ] Dev
	- [ ] Only build when changes have been pulled.
