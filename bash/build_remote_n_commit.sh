#!/bin/bash

echo ">>> Build with commit \"$1\""

cd .. || return
git pull
cd ../vinhmdev.github.io/ || return
git pull
cd ../vinhmdev/bash/ || return

bash build_local.sh

cd ../ || return
git pull
git add .
git commit -a -m "$1
---"
git push
cd bash/ || return

echo ">>> SUCCESS COMMIT LOCAL"

cd ../../vinhmdev.github.io/ || return
git add .
git commit -a -m "$1
---"
git push
cd ../vinhmdev/bash/ || return

echo ">>> SUCCESS BUILD REMOTE"
