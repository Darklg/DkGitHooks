#!/bin/bash

# Detect edited files in core v 0.1.3
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

## Load functions
###################################

DKGH_SOURCEDIR="$( dirname "${BASH_SOURCE[0]}" )/";
. "${DKGH_SOURCEDIR}/functions.sh";

## Invalid path list
###################################

DKGH_LIST_ERRORS="";

# WordPress
DKGH_LIST_ERRORS="${DKGH_LIST_ERRORS} wp-admin/ wp-includes/";

# Magento
DKGH_LIST_ERRORS="${DKGH_LIST_ERRORS} app/code/core/ app/design/frontend/base/";

## Test all files
###################################

DKGH_ERROR_RETURN='';
DKGH_ERROR_RETURN_TEST='';

for test_folder in ${DKGH_LIST_ERRORS}
do
    DKGH_ERROR_RETURN_TEST=$(dkgithooks_teststringingitdiffpath "${test_folder}");
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
