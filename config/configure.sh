#!/bin/bash

echo $STATUS
echo $REPO

if [ $STATUS == "clone" ]; then
 git clone git://github.com/aweir12/${REPO}
 cd $HOME/work/${REPO}
 git remote set-url origin git@github.com:aweir12/${REPO}.git
 nbstripout --install --attributes .gitattributes
fi

if [ $STATUS == "scratch" ]; then
 echo "Hello World"
fi