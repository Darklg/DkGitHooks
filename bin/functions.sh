#!/bin/bash

# Functions v 0.2.0
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

###################################
## Display errors if needed
###################################

function dkgithooks_displayerrors(){
    if [ "$DKGH_ERROR_RETURN" != '' ]; then
        echo "ERROR";
        echo "-----";
        printf "Please fix this to commit :%s\n\n" "${DKGH_ERROR_RETURN}";
        echo "If you want to commit anyway, please use :";
        echo "git commit --no-verify -m \"message\";";
        exit 1;
    fi;
}

###################################
## Test if strings have been added
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

###################################
## Test if files have been edited
###################################

function dkgithooks_teststringingitdiffpath(){
    test_folder=${1};

    # Search for the string to avoid in changed/new/deleted files
    _count_results=$(git diff --name-only --cached | grep "${test_folder}" | wc -l | awk '{print $1}');
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

###################################
## Test if files have been added
###################################

function dkgithooks_teststringingitdiffpathnew(){
    test_folder=${1};

    # Search for the string to avoid in changed/new/deleted files
    _count_results=$(git diff --name-only --cached | grep "${test_folder}" | wc -l | awk '{print $1}');
    # Add plural to the result word if needed.
    _results_str='result';
    if [[ "${_count_results}" -ge 2 ]]; then
        _results_str='results';
    fi;
    # Print any error
    if [[ "${_count_results}" -ge 1 ]]; then
        printf '\n - An "%s" file should not be tracked : %d %s.' "${test_folder}" "${_count_results}" "${_results_str}";
    fi;
}
