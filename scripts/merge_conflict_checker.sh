#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
GMC_EXITCODE="0"

if [ -z  "$1" ]
then
    DIRECTORY_TO_CHECK="."
else
    DIRECTORY_TO_CHECK=$1
fi

MARKER_COUNT=`grep --exclude-dir=ci -H -r "<<<<<<< HEAD" $DIRECTORY_TO_CHECK | wc -l | sed 's/^[ \t]*//;s/[ \t]*$//'`

if [ "$MARKER_COUNT" = "0" ]
then
    echo -e "${GREEN}No merge conlict marker <<<<<<< HEAD ${NC}"
else
    echo -e "${RED}There are some forgotten merge conflict marker (<<<<<<< HEAD) in the following files! "
    echo -e "${RED}-----------------------------------------------------------"
    grep --exclude-dir=ci -H -r "<<<<<<< HEAD" $DIRECTORY_TO_CHECK
    echo -e "${NC}"
    GMC_EXITCODE='1'
fi

MARKER_COUNT=`grep --exclude-dir=ci -H -r ">>>>>>> " $DIRECTORY_TO_CHECK | wc -l | sed 's/^[ \t]*//;s/[ \t]*$//'`

if [ "$MARKER_COUNT" = "0" ]
then
    echo -e "${GREEN}No merge conlict marker >>>>>>> ${NC}"
else
    echo -e "${RED}There are some forgotten merge conflict marker (>>>>>>>) in the following files! "
    echo -e "${RED}-----------------------------------------------------------"
    grep --exclude-dir=ci -H -r ">>>>>>> " $DIRECTORY_TO_CHECK
    echo -e "${NC}"
    GMC_EXITCODE='1'
fi

exit $GMC_EXITCODE
