#!/bin/bash
### INPUT
[[ -z "$1" ]] && echo "USE: [clone] [pull] [push] | [build] [test] [deploy] | [remove] [status]" && exit 0
### CONFIG
COMMAND=$1
echo "$COMMAND projects"
yes=$2
### GIT
# sh apicup.sh clone
# sh apicup.sh clone a
## sh apicup.sh remove a
## sh apicup.sh update a
### DEVOPS
# sh apicup.sh build
# sh apicup.sh deploy
# sh apicup.sh test
### CONFIG
LIST="git.txt"
echo -e "\e[33MGIT PROJECTS are loaded File: $LIST:"
cat $LIST
echo ""
### START
function apicup() {
  [[ -z "$yes" ]] && yes=""
  for URL in $(cat $LIST)
  do
    echo "::::::::::::::"
    echo -e "\e[33mGIT: [$URL]"
    #### Branch
    branch=${URL##*/}
    branch=${branch//[$'\t\r\n']}
    echo -e "\e[33mBRANCH: [$branch]"
    #### Project
    prefix="https://githab.com"
    project=${URL//$prefix/}
    suffix="/-/tree/$branch"
    project=${project//$suffix/}
    project=${project//[$'\t\r\n']}
    echo -e "\e[33mPROJECT: [$project]"
    ####
    if [[ $yes != "a" ]]
    then
      read -p "$COMMAND PROJECT: $project (blank=NO, y=YES, a=YES ALL):" yes
    fi
    ####
    if [[ $yes ! = "" ]]    
    then
      ./.devop/$COMMAND.sh $project $branch
      echo ""
    fi
  done
  echo -e "\e[39m"
}
### START
apicup
