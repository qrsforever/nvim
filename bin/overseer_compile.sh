#!/bin/bash

echo $1 $2

n=0
while (( n < 6 ))
do
    echo $n
    sleep 1
    (( n += 1 ))
done
