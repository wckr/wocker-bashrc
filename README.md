wocker-bashrc
===========

The .bashrc file for Wocker.

## Shortcut commands for Wocker

### Show the usage
```
$ wocker --help
```
or
```
$ wocker -h
```

### Run a new Wocker container named "wocker" using "ixkaito/wocker:latest"
```
$ wocker run
```

### Run a new Wocker container and assign another name
```
$ wocker run --name <containername>
```
or
```
$ wocker run --name=<containername>
```
e.g.
```
$ wocker run --name wordpress
```

### Use another docker image to run a new Wocker container
```
$ wocker run <image>
```
e.g.
```
$ wocker run ixkaito/wocker:centos6
```

### Use another docker image to run a new Wocker container and assign another name
```
$ wocker run --name <containername> <image>
```
or
```
$ wocker run --name=<containername> <image>
```
e.g.
```
$ wocker run --name wordpress ixkaito/wocker:centos6
```

### Stop all running containers
```
$ wocker stop --all
```
or
```
$ wocker stop -a
```

### Kill all running containers
```
$ wocker kill --all
```
or
```
$ wocker kill -a
```

### Force remove all containers
```
$ wocker rm --all
```
or
```
$ wocker rm -a
```
