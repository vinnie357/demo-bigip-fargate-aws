#!/bin/bash
echo "---installing awscli---"
apt-get install python3-setuptools
python3 -m pip install --upgrade pip
pip3 install awscli
echo "---installing awscli done---"