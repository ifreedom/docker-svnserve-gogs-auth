# Use Gogs for svnserve auth backend

![](https://images.microbadger.com/badges/image/ifreedom/svnserve-gogs-auth.svg)

Visit [Docker Hub](https://hub.docker.com/r/ifreedom/svnserve-gogs-auth/) see all available images and tags.

## Usage

To keep svn data out of Docker container, we do a volume (`/var/svn` -> `/data`) here, and for send request to Gogs, we use ENV value (GOGS_HOST=https://gogs.domain.lan) here, you can change them based on your situation.

```
# Pull image from Docker Hub.
$ docker pull ifreedom/svnserve-gogs-auth

# Create local directory for volume.
$ mkdir -p /var/svn

# Use `docker run` for the first time.
$ docker run -d --name=svnserve-gogs-auth -p 3690:3690 -e GOGS_HOST=https://gogs.domain.lan -v /var/svn:/data ifreedom/svnserve-gogs-auth

# Use `docker start` if you have stopped it.
$ docker start svnserve-gogs-auth

# Create test repo.
$ docker run --rm -v /var/svn:/data ifreedom/svnserve-gogs-auth svnadmin create /data/repos/test
```

note: The container default use http://gogs as GOGS_HOST, so you can also use container link to connect it to Gogs.
