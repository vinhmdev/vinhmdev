#!/bin/bash

cd ..
flutter pub get
flutter gen-l10n
flutter pub run build_runner build --delete-conflicting-outputs
cd bash || return

echo ">>> SUCCESS BUILD LIBRARY"