# docker-mapnik

> Mapnik Docker container with Python bindings

## Building

> :exclamation:
> Ensure your Docker build environment, be it a VM (if you use Docker for Mac or Windows) or bare metal,
> has **at least 4 gigabytes of memory**. Any less and you'll have to enjoy hella swapping.

* Do `docker build -t mapnik .`. It will take a long while, so best get another coffee.

## Image on dockerhub

* Image is available on dockerhub: `docker pull anuras/mapnik`

## Contents of the image

* Ubuntu 16.04 LTS
* Mapnik 3.0.10 (at the time of writing)
* Python 2.7 & Python 3

### Python bindings

* `/opt/python-mapnik` contains the Python bindings.
* The bindings are built for both Python 2.x and 3.x, and installed system-wide.
* If your app requires a virtualenv, `pip install -e /opt/python-mapnik` is likely your best bet.
* Otherwise, just `--system-site-packages` your virtualenv or don't use a virtualenv at all.

### Test apps

* The basic [Python world-rendering script][gspy] is installed in `/opt/demos/world.py`.
  * Use `cd /opt/demos; python2 world.py` to try that Python 2.x works.
  * Use `cd /opt/demos; python3 world.py` to try that Python 3.x works.
  * The script outputs a `world.png`. You can use `docker cp` to look at it.

[gspy]: https://github.com/mapnik/mapnik/wiki/GettingStartedInPython
[rmjs]: https://github.com/mapnik/node-mapnik#usage