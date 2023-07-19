#!/bin/bash

twojastara () {
    echo $1
    echo $2
}

case $1 in
   "twojastara")
     shift
     option=$1
     twojastara ${option} "cokolwiek"
     ;;
esac