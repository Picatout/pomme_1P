#!/bin/bash 

# usage:
# ./build.sh [flash]
# flash after build 

if [[ ! -z $1 && ($1 == "flash") ]]; then 
    make -fnucleo_8s207.mk && make -fnucleo_8s207.mk flash 
else 
    make -fnucleo_8s207.mk
fi 




