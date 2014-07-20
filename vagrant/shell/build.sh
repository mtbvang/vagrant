#!/usr/bin/env bash

cd $1
echo "Running bundle install in: "; pwd
source /usr/local/rvm/scripts/rvm
rvm use 2.0.0 --default
ruby -v
bundle install
rake
