#!/bin/bash

# 打印输入的参数

for i in $*
do
    echo $i
done

for j in $@
do
    echo $j
done

for k in "$*"
do
    echo $k
done

for t in "$@"
do
    echo $t
done
