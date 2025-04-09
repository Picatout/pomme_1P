#!/bin/bash 

# usage:
# ./build.sh s207|l151 [flash]
# flash after build 

if [[ ! -z $1 && ($1 == 's207')]]; then 
    echo stm8s207
    if [[ ! -z $2 && ($2 == 'flash') ]]; then 
        make -fstm8s207.mk && make -fstm8s207.mk flash 
    else 
        make -fstm8s207.mk
    fi 
elif [[ ! -z $1 && ($1 == 'l151')]]; then
    echo stm8l151 
    if [[ ! -z $2 && ($2 == 'flash') ]]; then 
        make -fstm8l151.mk && make -fstm8l151.mk flash 
    else 
        make -fstm8l151.mk
    fi 
else
    echo usage:
    echo   './build.sh s207||l151 [flash]'
    echo   add flash option to flash mcu after build
fi 


