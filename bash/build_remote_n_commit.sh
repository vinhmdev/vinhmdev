#!/bin/bash

cd .. || return
git pull
cd ../vinhmdev.github.io/ || return
git pull
cd ../vinhmdev/bash/ || return

bash build_local.sh

cd ../ || return
git pull
git add .
git commit -a -m "build vinhmdev"
git push
cd bash/ || return

cd ../../vinhmdev.github.io/ || return
git add .
git commit -a -m "build vinhmdev"
git push
cd ../vinhmdev/bash/ || return

echo "SUCCESS BUILD REMOTE"
