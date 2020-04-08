## powerline_exporter

A prometheus exporter for powerline devices that exposes tx/rx data for each powerline device.  Any powerline device supported by Faifa should work.  Based off [monitoring homeplug devices](https://www.tablix.org/~avian/blog/archives/2018/05/monitoring_homeplug_av_devices/).

## Example

![Grafana Dashboard Screenshot](/examples/screenshot.png "Grafana Dashboard Screenshot")

## Install

### Faifa

You'll need a working install of this version of faifa.  Instructions for an ubuntu install:

```
cd /usr/local/bin/
git clone https://github.com/avian2/faifa
cd faifa
apt-get install git autoconf build-essential -y
apt-get install libpcap-dev -y
apt-get install libevent-dev -y
autoreconf --install
./configure
make
sudo make install
ldconfig -v

./faifa -i eno1 -a FF:FF:FF:FF:FF:FF
```

### powerline_exporter

Due to the requirement to listen on an interface for powerline traffic, this is likely very difficult to run in a containerised environment.  If anyone manages to due this then please raise a PR against the docs with instructons.

```
git clone 
cp powerline.conf.example powerline.conf
# Edit config as needed
./powerline_exporter
sleep 2

curl http://localhost:9859

```

## Configuration

### powerline_exporter

```
exporter:
  # Log verbose output to STDERR
  verbose: true
  # Metric prefix in response
  prefix: powerline_exporter_
  # Cache time in seconds to cache the prometheus output
  cache: 10
  # Hostname of server the exporter is running on
  host: localhost
  # Port the prometheus server runs on
  port: 9859
  # Faifa executable location
  faifa: /usr/local/bin/faifa/faifa
  # Ethernet interface to listen on
  interface: eno1

# MAC address to adaptor mapping
stations:
  BC:F2:AF:03:41:BC: Study
  F4:06:8D:7E:05:92: Lounge
  30:D3:2D:04:52:5B: Kitchen
  F4:06:8D:17:58:5D: Bedroom1
  30:D3:2D:43:B6:20: Bedroom2
  30:D3:2D:04:4F:92: Bedroom3
```

The MAC-> Adaptor label mapping is required.  These can typically be found in the powerline configuration software e.g for devolo adaptors 'devolo Cockpit'

See [powerline_exporter.conf.example](/powerline_exporter.conf.example).

### Prometheus

### Prometheus

```
  - job_name: ''
    scrape_interval: 1m
    scrape_timeout: 30s
    static_configs:
    - targets:
      - server.home:9859
```

### Grafana

Example dashboard [config](/examples/grafana.json)
