#!/bin/bash

cd ..
flutter pub get
flutter gen-l10n
cd bash || return