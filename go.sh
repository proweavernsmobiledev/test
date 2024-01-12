#!/bin/bash

# Set color variables
FG_Ba='\e[0;30m' #Black
FG_Re='\e[0;31m' #Red
FG_Gr='\e[0;32m' #Green
FG_Ye='\e[0;33m' #Yellow
FG_Bu='\e[0;34m' #Blue
FG_Pu='\e[0;35m' #Purple
FG_Cy='\e[0;36m' #Cyan
FG_Wh='\e[0;37m' #White
FG_NC='\e[0;0m'  #No Color

git_clone=''
vue_template_repo='https://github.com/example/vue-template.git'
ci_template_repo='https://github.com/example/ci-template.git'
git_branch='main'
is_new='n'

# Print colored text
echo -e -n "${FG_Wh}Github Repo Link: ${FG_Cy}"
read git_link
echo -e -n "${FG_Wh}Branch [Default: ${FG_Re}main${FG_Wh}]: ${FG_Cy}"
read git_branch
echo -e -n "${FG_Wh}Is a new project? [Default: ${FG_Re}n${FG_Wh}][y/n]: ${FG_Cy}"
read is_new

if [[ $is_new == 'y' ]]; then
    echo -e -n "${FG_Wh}Clone NSSP Templates [Default:  ${FG_Re}n${FG_Wh}][${FG_Re}vue${FG_Wh}|${FG_Re}ci${FG_Wh}]: ${FG_Cy}"
    read git_clone
fi


git_branch=${git_branch:-main}
is_new=${is_new:-n}

if [[ $is_new == 'y' ]]; then
    git init
    git remote add origin $git_link

    if [[ $git_clone == 'vue' ]]; then
        git clone $vue_template_repo .
    elif [[ $git_clone == 'ci' ]]; then
        git clone $ci_template_repo .
    fi

    git add .
    git commit -m "Initial commit"
    
    git checkout -b release
    git checkout -b main

    if [[ $git_branch == 'main' || $git_branch == 'release' ]]; then
        echo -e -n "${FG_Wh}What's your dev branch name? ${FG_Cy}dev_"
        read dev_branch
        git checkout -b "dev_$dev_branch"
    fi

    
    git checkout -b $git_branch
    
    git push origin $git_branch
else
    

    if ! git show-ref --verify --quiet "refs/heads/$git_branch"; then
        git checkout -b $git_branch
    fi

    git pull origin $git_branch
fi

read
