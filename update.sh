#!/bin/sh
#git submodule update --init --recursive
#git submodule foreach git fetch
#git submodule foreach git checkout master
#git submodule foreach git pull origin master

git submodule foreach git pull origin master
