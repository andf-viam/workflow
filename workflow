#!/bin/bash

## Bash script to automate the initial setup of new docs
## work. This script:
##
##   - Clones your fork (of the upstream docs repo)
##   - Fetches the latest state of upstream master
##   - Creates a new branch based on your provided branchname
##   - Opens up VSCode with the fresh clone / branch as workspace

## You must pass your intended branchname as a parameter to this
## script, like:
##
##   workflow DOC-12345-fix-typo-in-example

## To make use of the `code` command to open VSCode from the
## command line, you'll need to have followed these instructions:
##
##   https://code.visualstudio.com/docs/editor/command-line#_launching-from-command-line

############################################################
## YOUR VALUES ##
#################

## Your github username:
GITUSER=andf-viam

## Your docs workspace (i.e. where to git clone to)
## If you use a ~ in the path, don't quote the value:
WORKSPACE=~/Documents/docs_workspace

############################################################
## BEGIN SCRIPT ##
##################

## Collect intended branchname from provided parameter:
BRANCHNAME=$1

# Quit if no parameters were passed or if $BRANCHNAME is incomplete:
if [ -z $BRANCHNAME ]; then
   echo -e "\nERROR: You must provide the intended branch name as a parameter."
   echo -e "       Exiting ...\n"
   exit;
elif [ `echo $BRANCHNAME | awk -F\- '{print NF-1}'` -lt 2 ]; then
   echo -e "\nERROR: Your branchname must consist of a JIRA TICKET + a DESCRIPTION."
   echo -e "       Exiting ...\n"
   exit;
fi


# Check for existing docs dir in docs workspace, just in case:
if [ -d $WORKSPACE/docs ]; then
   echo -e "\nERROR: An existing docs dir was found here:"
   echo -e "       $WORKSPACE/docs"
   echo -e "       Please manually correct move or rename this, then rerun this program."
   echo -e "       Exiting ...\n"
   exit;
fi

## Start new repo setup:
cd $WORKSPACE
git clone git@github.com:$GITUSER/docs.git
cd docs
git remote add upstream git@github.com:viamrobotics/docs.git

git pull upstream main
git checkout -b $BRANCHNAME upstream/main
git pull --rebase

## Rename `docs` based on BRANCHNAME:
cd ..
mv docs docs_$BRANCHNAME

## Open new branch in VS Code:
cd docs_$BRANCHNAME
code .

