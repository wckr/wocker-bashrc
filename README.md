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

### Update Wocker

```
$ wocker update
```

### Run a new Wocker container using "ixkaito/wocker:latest"

```
$ wocker run
```

### Run a new Wocker container and assign a name

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
$ wocker run wocker/wocker:centos6
```

### Use another docker image to run a new Wocker container and assign a name

```
$ wocker run --name <containername> <image>
```

or

```
$ wocker run --name=<containername> <image>
```

e.g.

```
$ wocker run --name wordpress wocker/wocker:centos6
```

### Remove all containers and files

```
$ wocker destroy
```
