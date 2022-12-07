#!/bin/bash

cd ../
flutter clean
flutter pub get
flutter build web
rm -rfv ../vinhmdev.github.io/www/
mkdir ../vinhmdev.github.io/www/
cp -rfv ./build/web/** ../vinhmdev.github.io/www
cd ./bash || return

echo "SUCCESS BUILD LOCAL"
