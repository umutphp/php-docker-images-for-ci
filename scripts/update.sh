#!/bin/bash

for dir in /tools/*; 
do
    if [[ -d $dir ]]; then
        for subdir in $dir/*;
        do
            if [[ -d $subdir ]]; then
                cd $subdir
                composer update
                cd -
            fi
        done
    fi
done
