#!/bin/bash

# Prevent invalid PHP v 0.1
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

## Files list
###################################

php_files=$(git status --short | awk '{ print $2 }' | grep -E '\.php|phtml$')

## Test model
###################################

function dkgithooks_testinvalidphpfile(){
    test_file=${1};
    test_group=${2};

    invalid_file=$(php -l "${test_file}");
    if [[ $invalid_file != "No syntax"* ]];  then
        printf "\n - ${invalid_file}";
    fi
    printf '';
}

## Test all files
###################################

DKGH_ERROR_RETURN='';
DKGH_ERROR_RETURN_TEST='';

for php_file in $php_files; do
    DKGH_ERROR_RETURN_TEST=$(dkgithooks_testinvalidphpfile "${php_file}");
    DKGH_ERROR_RETURN="${DKGH_ERROR_RETURN}${DKGH_ERROR_RETURN_TEST}";
done


## Display errors if needed
###################################

if [ "$DKGH_ERROR_RETURN" != '' ]; then
    printf "Error(s) : Fix this before commit.%s\n\nIf there is a false result, please use :\ngit commit --no-verify." "${DKGH_ERROR_RETURN}";
    #exit 1;
fi;

## Clean up
###################################

unset DKGH_ERROR_RETURN_TEST;
unset DKGH_ERROR_RETURN;
