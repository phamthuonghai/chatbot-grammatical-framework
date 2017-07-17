# SUBWAY CHATBOT

## Installation
### Prerequisites
```bash
sudo apt-get install autoconf automake libtool make
sudo apt-get install python python-pip python-dev
sudo apt-get install virtualenv
```
### GF
Download GF lib from http://www.grammaticalframework.org/download/gf_3.8-1_amd64.deb (64-bit) or http://www.grammaticalframework.org/download/gf_3.8-1_i386.deb (32-bit)

Install GF
```bash
sudo dpkg -i gf_3.8-1_amd64.deb
```

Create a virtual environment
```bash
virtualenv --no-site-packages -p python2 env
source ./env/bin/activate
```

Install GF Python API
```bash
git clone git@github.com:GrammaticalFramework/GF.git
cd src/runtime/c/
autoreconf -i
./configure
make
make install
cd ../python
python setup.py build
python setup.py install
cd ../../../..
```

### Python packages
```bash
pip install requirements.txt
```

## Demo

### Run the chatbot
``` bash
python app.py
```

![Demo](Demo.png?raw=true "Demo")


## Acknowledgements
* UI designed by Fabio Ottaviani https://twitter.com/supahfunk
* This grammar is based on http://www.cse.chalmers.se/alumni/bringert/publ/gf-voicexml/gf-voicexml.pdf