#!/bin/bash

## declare an array variable
declare -a array=("5.6" "7.0" "7.1" "7.2" "7.3" "7.4")

# get length of an array
arraylength=${#array[@]}

# use for loop to read all values and indexes
for (( i=1; i<${arraylength}+1; i++ ));
do
    echo "********************************************************"
    echo "Building image php:" ${array[$i-1]} " - " $i " of " ${arraylength}
    echo "********************************************************"
    cd images/${array[$i-1]}/
    docker build -t umutphp/php-docker-images-for-ci:${array[$i-1]} .
    docker push umutphp/php-docker-images-for-ci:${array[$i-1]}
    cd -
    echo "********************************************************"
    echo "Image is pushed to remote"
    echo "********************************************************"
done
