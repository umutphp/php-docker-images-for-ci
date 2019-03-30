#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
EXITCODE='0'
set -o noglob
for file in `cat .gitignore | grep -v \#`
do
    NUMBER=$(find . -name "$file" | wc -l | tr -dc '0-9')
    
    if [ "$NUMBER" = "0" ]
    then
        echo -e "${GREEN}Line $file is ok!${NC}"
    else
        echo -e "${RED}Line $file is not ok with ${NUMBER} files! "
        echo -e "${RED}-----------------------------------------------------------"
        find . -name "$file"
        echo -e "${RED}-----------------------------------------------------------"
        echo -e "${NC}"
    fi
done

exit $EXITCODE
