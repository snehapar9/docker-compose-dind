#!/bin/bash -x
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | bash -s -- -b /usr/local/bin

git clone https://github.com/cplee/github-actions-demo.git
cd github-actions-demo