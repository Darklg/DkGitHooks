#!/bin/bash

# Prevent invalid PHP v 0.1.1
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

## Load functions
###################################

DKGH_SOURCEDIR="$( dirname "${BASH_SOURCE[0]}" )/";
. "${DKGH_SOURCEDIR}/functions.sh";

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

## Display errors
###################################

dkgithooks_displayerrors;

## Clean up
###################################

unset DKGH_ERROR_RETURN_TEST;
unset DKGH_ERROR_RETURN;
unset DKGH_SOURCEDIR;
