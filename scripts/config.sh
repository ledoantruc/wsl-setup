#!/bin/bash
#
### config applications ###

source ./scripts/data.sh

# git
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"