#!/bin/bash 

# usage:
# ./build.sh [flash]
# [flash] after build 

if [[ ! -z $1 && ($1 == 'flash') ]]; then 
    make -fstm8s207.mk && make -fstm8s207.mk flash 
else 
    make -fstm8s207.mk
fi 

