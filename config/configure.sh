#!/bin/bash

echo $STATUS
echo $REPO

if [ $STATUS == "clone" ]; then
 git clone git://github.com/aweir12/${REPO}
fi

