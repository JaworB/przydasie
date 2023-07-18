#!/bin/bash

twojastara () {
    echo $1
}

case $1 in
   "twojastara")
     shift
     option=$1
     twojastara ${option}
     ;;
esac