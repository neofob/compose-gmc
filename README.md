# Providing metrics from the Geiger Counter as a service
_author_: *tuan t. pham*


## Requirements
* [GMC][0] device(s)
* [pygmc][1] Python package
* USB cable connected to the computer
* computer that runs Linux
* Docker if you use Docker image
* [`docker-compose`][2] if you want to use `docker-compose`

## Build Docker image
```bash
make
```

## Run as a docker service
```bash
docker-compose up -d
```

## Run python script
```bash
pip install -r requirements.txt
./gmc-service.py
```


[0]: https://gqelectronicsllc.com
[1]: https://github.com/Wikilicious/pygmc
[2]: https://github.com/docker/compose/releases
