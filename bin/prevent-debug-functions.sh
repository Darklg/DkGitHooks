#!/bin/sh

###################################
## Prevent debug functions
###################################

LIST_ERRORS[0]="console.log";
LABEL_ERRORS[0]='JS'
LIST_ERRORS[1]='var_dump var_export print_r Zend_Debug';
LABEL_ERRORS[1]='PHP'
ERROR_RETURN='';

for i in 0 1
do
    for test_error in ${LIST_ERRORS[${i}]}
    do
        # Search for the string to avoid only in GIT DIFF, only on new lines.
        count_results=$(git diff --cached | grep ^+ | grep $test_error | wc -l | awk '{print $1}');
        if [[ "$count_results" -ge 1 ]]; then
            ERROR_RETURN="${ERROR_RETURN}\n - [${LABEL_ERRORS[${i}]}]\t Remove any new '${test_error}' statement : ${count_results} result(s).";
        fi;
    done;
done;

# Display errors if needed
if [[ $ERROR_RETURN != '' ]]; then
    echo "Error(s) : Fix this before commit.${ERROR_RETURN}\n\nIf there is a false result, please use :\ngit commit --no-verify.";
    exit 1;
fi;

