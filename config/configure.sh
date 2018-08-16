#!/bin/bash

TOKEN=$(cat $HOME/api-token.txt)
echo $TOKEN

if [ $STATUS == "clone" ]; then
 git clone git://github.com/aweir12/${REPO}
 cd $HOME/work/${REPO}
 git remote set-url origin git@github.com:aweir12/${REPO}.git
 nbstripout --install --attributes .gitattributes
fi

if [ $STATUS == "scratch" ]; then
 echo "#### Not Saving Code To A Repository!!! ####"
 cd $HOME/work
 mkdir $REPO
 fi

if [ $STATUS == "new" ]; then
 echo "Creating New Repository:" $REPO
 curl -s -H 'Authorization: token '${TOKEN}'' \
    -d '{ "name":"'${REPO}'", "auto_init": true }' \
    https://api.github.com/user/repos > /dev/null
 git clone git://github.com/aweir12/${REPO}
 cd $HOME/work/${REPO}
 git remote set-url origin git@github.com:aweir12/${REPO}.git
 nbstripout --install --attributes .gitattributes
 rm $HOME/api-token.txt
fi