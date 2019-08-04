#!/bin/bash

# Prevent new debug functions v 0.3.0
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

## Load functions
###################################

DKGH_SOURCEDIR="$( dirname "${BASH_SOURCE[0]}" )/";
. "${DKGH_SOURCEDIR}/functions.sh";

## Error list
###################################

# JavaScript
DKGH_LIST_ERRORS[0]="console.log";
DKGH_LABEL_ERRORS[0]='JS';

# PHP
DKGH_LIST_ERRORS[1]='var_dump var_export print_r Zend_Debug die( exit( die;';
DKGH_LABEL_ERRORS[1]='PHP';

if [[ -f ".dkgithooks_excluded_words" ]];then
    DKGH_LIST_ERRORS[2]=$(cat .dkgithooks_excluded_words);
    DKGH_LABEL_ERRORS[2]='CUSTOM';
fi;

## Test all files
###################################

DKGH_ERROR_RETURN='';
DKGH_ERROR_RETURN_TEST='';

DKGH_LIST_ERRORS_LEN=${#DKGH_LIST_ERRORS[@]};
for (( i=0; i<${DKGH_LIST_ERRORS_LEN}; i++ ));
do
    for test_error in ${DKGH_LIST_ERRORS[${i}]}
    do
        DKGH_ERROR_RETURN_TEST=$(dkgithooks_testaddedstringingitdiff "${test_error}" "${DKGH_LABEL_ERRORS[${i}]}");
        DKGH_ERROR_RETURN="${DKGH_ERROR_RETURN}${DKGH_ERROR_RETURN_TEST}";
    done;
done;

## Display errors
###################################

dkgithooks_displayerrors;

## Clean up
###################################

unset DKGH_ERROR_RETURN;
unset DKGH_ERROR_RETURN_TEST;
unset DKGH_LABEL_ERRORS;
unset DKGH_LIST_ERRORS;
unset DKGH_LIST_ERRORS_LEN;
unset DKGH_SOURCEDIR;
