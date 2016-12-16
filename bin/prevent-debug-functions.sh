#!/bin/bash

# Prevent debug functions v 0.2
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

## Error list
###################################

# JavaScript
DKGH_LIST_ERRORS[0]="console.log";
DKGH_LABEL_ERRORS[0]='JS';

# PHP
DKGH_LIST_ERRORS[1]='var_dump var_export print_r Zend_Debug die(';
DKGH_LABEL_ERRORS[1]='PHP';

## Test model
###################################

function dkgithooks_testaddedstringingitdiff(){
    test_error=${1};
    test_group=${2};

    # Search for the string to avoid only in GIT DIFF, only on new lines.
    _count_results=$(git diff --cached | grep ^+ | grep "${test_error}" | wc -l | awk '{print $1}');
    # Add plural to the result word if needed.
    _results_str='result';
    if [[ "${_count_results}" -ge 2 ]]; then
        _results_str='results';
    fi;
    # Print any error
    if [[ "${_count_results}" -ge 1 ]]; then
        printf '\n - [%s] Remove any new "%s" statement : %d %s.' "${test_group}" "${test_error}" "${_count_results}" "${_results_str}";
    fi;
}

## Test all files
###################################

DKGH_ERROR_RETURN='';
DKGH_ERROR_RETURN_TEST='';

for i in 0 1
do
    for test_error in ${DKGH_LIST_ERRORS[${i}]}
    do
        DKGH_ERROR_RETURN_TEST=$(dkgithooks_testaddedstringingitdiff "${test_error}" "${DKGH_LABEL_ERRORS[${i}]}");
        DKGH_ERROR_RETURN="${DKGH_ERROR_RETURN}${DKGH_ERROR_RETURN_TEST}";
    done;
done;

## Display errors if needed
###################################

if [ "$DKGH_ERROR_RETURN" != '' ]; then
    printf "Error(s) : Fix this before commit.%s\n\nIf there is a false result, please use :\ngit commit --no-verify." "${DKGH_ERROR_RETURN}";
    exit 1;
fi;

## Clean up
###################################

unset DKGH_LIST_ERRORS;
unset DKGH_LABEL_ERRORS;
unset DKGH_ERROR_RETURN_TEST;
unset DKGH_ERROR_RETURN;
