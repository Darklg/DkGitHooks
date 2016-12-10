#!/bin/bash

# Detect core edit v 0.1
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

## Invalid path list
###################################

DKGH_LIST_ERRORS="";

# WordPress
DKGH_LIST_ERRORS="${DKGH_LIST_ERRORS} wp-admin/ wp-includes/";

# Magento
DKGH_LIST_ERRORS="${DKGH_LIST_ERRORS} app/code/core/ app/design/frontend/base/";

## Test model
###################################

function dkgithooks_teststringingitdiffpath(){
    test_folder=${1};

    # Search for the string to avoid only in GIT DIFF, only on new lines.
    _count_results=$(git diff --name-only | grep "${test_folder}" | wc -l | awk '{print $1}');
    # Add plural to the result word if needed.
    _results_str='result';
    if [[ "${_count_results}" -ge 2 ]]; then
        _results_str='results';
    fi;
    # Print any error
    if [[ "${_count_results}" -ge 1 ]]; then
        printf '\n - Discard any modification on core file in "%s" folder : %d %s.' "${test_folder}" "${_count_results}" "${_results_str}";
    fi;
}

## Test all files
###################################

DKGH_ERROR_RETURN='';
DKGH_ERROR_RETURN_TEST='';

for test_folder in ${DKGH_LIST_ERRORS}
do
    DKGH_ERROR_RETURN_TEST=$(dkgithooks_teststringingitdiffpath "${test_folder}");
    DKGH_ERROR_RETURN="${DKGH_ERROR_RETURN}${DKGH_ERROR_RETURN_TEST}";
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
unset DKGH_ERROR_RETURN_TEST;
unset DKGH_ERROR_RETURN;
