#!/bin/bash

cd ../ || return
git add .
git commit -a -m "build vinhmdev"
git push
cd bash/ || return

cd ../../vinhmdev.github.io/ || return
git pull
cd ../vinhmdev/bash/ || return

sh build_local.sh

cd ../../vinhmdev.github.io/ || return
git add .
git commit -a -m "build vinhmdev"
git push
cd ../vinhmdev/bash/ || return

echo "SUCCESS BUILD REMOTE"
