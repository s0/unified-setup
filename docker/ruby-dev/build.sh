#! /bin/bash

docker build -t ruby-dev --build-arg UID=`id -u` --build-arg UNAME=`whoami` ./
