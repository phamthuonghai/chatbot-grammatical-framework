# SUBWAY CHATBOT
When it comes to implementing a chatbot that will be used in real life, developers usually construct a work flow of which questions the chatbot has to ask the user to acquire adequate information that can lead to a decision or action.

However, taking the advantage of **variants parameter** - a feature of [Grammatical Framework](http://www.grammaticalframework.org/), we can instruct the chatbot to construct its work flow without explicit step-by-step declaration.

This repo is to demonstrate that feature with a web-based chatbot for customers to order Subway.

_Disclaimer: this work has nothing to do with Subway at all, except the fact that I ate their sandwiches a lot during my MSc 1st year._

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

![Demo](demo.png?raw=true "Demo")


## Acknowledgements
* UI designed by Fabio Ottaviani https://twitter.com/supahfunk
* This grammar is based on http://www.cse.chalmers.se/alumni/bringert/publ/gf-voicexml/gf-voicexml.pdf
