#!/bin/bash

sh build_local.sh
cd ../../vinhmdev.github.io/ || return
git pull
git add .
git commit -a -m "build vinhmdev"
git push
cd ../vinhmdev/bash/ || return

echo "SUCCESS BUILD REMOTE"
