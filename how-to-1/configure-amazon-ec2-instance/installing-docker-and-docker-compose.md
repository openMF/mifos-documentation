# Installing docker & docker-compose

### Install docker and docker-compose

```bash
$ sudo amazon-linux-extras install docker
$ sudo systemctl enable docker.service
$ sudo systemctl start docker.service
$ sudo usermod -a -G docker ec2-user
$ sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

After installing components and execute required steps, please logout and login back to machine.

**Checking docker setup**

```bash
$ docker version
Client:
 Version:           18.06.1-ce
 API version:       1.38
 Go version:        go1.10.3
 Git commit:        e68fc7a215d7133c34aa18e3b72b4a21fd0c6136
 Built:             Mon Mar  4 21:25:41 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          18.06.1-ce
  API version:      1.38 (minimum version 1.12)
  Go version:       go1.10.3
  Git commit:       e68fc7a/18.06.1-ce
  Built:            Mon Mar  4 21:27:07 2019
  OS/Arch:          linux/amd64
  Experimental:     false
```

```bash
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE

```

```bash
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

```bash
$ docker-compose version
docker-compose version 1.22.0, build f46880fe
docker-py version: 3.4.1
CPython version: 3.6.6
OpenSSL version: OpenSSL 1.1.0f  25 May 2017
```

