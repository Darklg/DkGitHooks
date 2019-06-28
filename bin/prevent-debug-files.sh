#!/bin/bash

# Prevent debug files v 0.1.0
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

## Load functions
###################################

DKGH_SOURCEDIR="$( dirname "${BASH_SOURCE[0]}" )/";
. "${DKGH_SOURCEDIR}/functions.sh";

## Invalid files list
###################################

DKGH_LIST_ERRORS="";

# WordPress
DKGH_LIST_ERRORS="${DKGH_LIST_ERRORS} debug.log error_log";

## Test all files
###################################

DKGH_ERROR_RETURN='';
DKGH_ERROR_RETURN_TEST='';

for test_file in ${DKGH_LIST_ERRORS}
do
    DKGH_ERROR_RETURN_TEST=$(dkgithooks_teststringingitdiffpathnew "${test_file}");
    DKGH_ERROR_RETURN="${DKGH_ERROR_RETURN}${DKGH_ERROR_RETURN_TEST}";
done;

## Display errors
###################################

dkgithooks_displayerrors;

## Clean up
###################################

unset DKGH_LIST_ERRORS;
unset DKGH_ERROR_RETURN_TEST;
unset DKGH_ERROR_RETURN;
unset DKGH_SOURCEDIR;
