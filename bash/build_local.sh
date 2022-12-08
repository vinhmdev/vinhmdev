#!/bin/bash

cd ../
flutter clean
flutter pub get
flutter build web

cd ../vinhmdev.github.io/ || return
git rm -rfv .
cd ../vinhmdev/ || return

cp -rfv ./build/web/** ../vinhmdev.github.io

cd bash || return

echo "SUCCESS BUILD LOCAL"
