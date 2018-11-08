FROM ubuntu:16.04

# Prerequisites and runtimes
RUN apt-get update
RUN apt-get upgrade -y && apt-get install -y --no-install-recommends \
    build-essential sudo software-properties-common curl \
    libboost-dev libboost-filesystem-dev libboost-program-options-dev libboost-python-dev libboost-regex-dev libboost-system-dev libboost-thread-dev libicu-dev libtiff5-dev libfreetype6-dev libpng12-dev libxml2-dev libproj-dev libsqlite3-dev libgdal-dev libcairo-dev python-cairo-dev postgresql-contrib libharfbuzz-dev \
    python3-dev python-dev git python-pip python-setuptools python-wheel python3-setuptools python3-pip python3-wheel

# Mapnik
ENV MAPNIK_VERSION 3.0.21
RUN curl -SL https://github.com/mapnik/mapnik/releases/download/v${MAPNIK_VERSION}/mapnik-v${MAPNIK_VERSION}.tar.bz2 | tar -xj -C /tmp/
#RUN curl -s https://mapnik.s3.amazonaws.com/dist/v${MAPNIK_VERSION}/mapnik-v${MAPNIK_VERSION}.tar.bz2 | tar -xj -C /tmp/
RUN cd /tmp/mapnik-v${MAPNIK_VERSION} && python scons/scons.py configure
RUN cd /tmp/mapnik-v${MAPNIK_VERSION} && make JOBS=4 && make install JOBS=4

# Python Bindings
ENV PYTHON_MAPNIK_COMMIT 588fc90624ce8b1952dfa3db3d8c7722f3420cbb
RUN mkdir -p /opt/python-mapnik && curl -L https://github.com/mapnik/python-mapnik/archive/${PYTHON_MAPNIK_COMMIT}.tar.gz | tar xz -C /opt/python-mapnik --strip-components=1
RUN cd /opt/python-mapnik && python2 setup.py install && python3 setup.py install && rm -r /opt/python-mapnik/build

# Python libraries
RUN pip install --upgrade pip
RUN pip install Pillow numpy geopy

# Tests
RUN apt-get install -y unzip
RUN mkdir -p /opt/demos
COPY world.py /opt/demos/world.py
COPY 110m-admin-0-countries.zip /opt/demos/110m-admin-0-countries.zip
RUN cd /opt/demos && unzip 110m-admin-0-countries.zip && rm 110m-admin-0-countries.zip
COPY stylesheet.xml /opt/demos/stylesheet.xml

