#Download base image ubuntu 22.04
FROM ubuntu:22.04

RUN apt update && apt install -y apt-utils apt-transport-https software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y
# PlotJuggler Dependencies
RUN apt update && apt install apt-utils apt-transport-https cmake git build-essential qtbase5-dev \
    libqt5svg5-dev libqt5websockets5-dev libqt5opengl5-dev libqt5x11extras5-dev nano qtchooser qt5-qmake qtbase5-dev-tools -y

# openpilot stuff
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y --no-install-recommends \
  build-essential \
  cmake \
  libbfd-dev \
  libdwarf-dev \
  libzmq3-dev \
  libdw-dev \
  python3.8 \
  python3.8-dev \
  python3.8-venv \
  python3.8-lib2to3 \
  python3.8-distutils \
  wget \
  software-properties-common \
  qtchooser \
  qt5-qmake \
  qtbase5-dev-tools \
  qtbase5-dev \
  libqt5svg5-dev \
  libqt5websockets5-dev \
  libqt5opengl5-dev \
  libqt5x11extras5-dev \
  # opendbc/cereal
  capnproto \
  curl \
  git \
  libbz2-dev \
  libcapnp-dev \
  libssl-dev \
  libffi-dev \
  libreadline-dev \
  libsqlite3-dev \
  clang \
  ocl-icd-opencl-dev \
  opencl-headers

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1
RUN update-alternatives --config python

RUN apt-get install -y python3-pip python-is-python3 python3-openssl

RUN pip install pkgconfig jinja2

# installs scons, pycapnp, cython, etc.
ENV PYTHONPATH /tmp/plotjuggler/3rdparty
COPY 3rdparty/opendbc/requirements.txt /tmp/
RUN pip install Cython && pip install --no-cache-dir -r /tmp/requirements.txt
