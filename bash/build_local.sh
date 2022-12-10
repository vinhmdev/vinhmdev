#!/bin/bash

cd ../
flutter clean
cd bash || return

bash build_library.sh

cd .. || return
flutter build web
cd ../vinhmdev.github.io/ || return
git rm -rv .
cd ../vinhmdev/ || return
cp -rfv ./build/web/** ../vinhmdev.github.io
cd bash || return

echo "SUCCESS BUILD LOCAL"
