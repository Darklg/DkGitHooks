#!/bin/bash

# DK Install Hooks v 0.3
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) @Darklg
# @license     MIT

###################################
## Get vars
###################################

SOURCEDIR="$( dirname "${BASH_SOURCE[0]}" )/";

###################################
## Check if everything is ok
###################################

if [ ! -d ".git/" ]; then
    echo "This is not a .git directory !";
    return;
fi;

###################################
## Insert hooks
###################################

hook_list="pre-commit";
for current_hook in $hook_list
do
    # Check if hook is already installed.
    if [ -f ".git/hooks/${current_hook}" ]; then
        echo "${current_hook} is already installed.";
        continue;
    fi;

    # Check if the user wants to install this hook.
    read -p "- Do you want to install ${current_hook} ? [Y/n] : " install_current
    if [ "${install_current}" == 'n' ]; then
        continue;
    fi;

    # Copy hook file
    cp "${SOURCEDIR}hooks/${current_hook}" ".git/hooks/${current_hook}";

    # Replace path
    sed -i '' "s~##dkgithookspath##~. ${SOURCEDIR}bin/~" ".git/hooks/${current_hook}";

    # Confirm message
    echo "-- ${current_hook} hook is now installed.";

done;
