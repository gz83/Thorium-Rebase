#!/bin/bash

# Copyright (c) 2022 Alex313031 and Midzer.

YEL='\033[1;33m' # Yellow
RED='\033[1;31m' # Red
GRE='\033[1;32m' # Green
c0=$'\033[0m' # Reset Text
bold=$'\033[1m' # Bold Text
underline=$'\033[4m' # Underline Text

# Error handling
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "${RED}Failed $*"; }

printf "\n" &&
printf "${YEL}Building .dmg of Chromium...\n" &&
printf "${GRE}\n" &&

# Fix file attr
xattr -csr out/thorium/Chromium.app &&

# Sign binary
codesign --force --deep --sign - out/thorium/Chromium.app &&

# Build dmg package
chrome/installer/mac/pkg-dmg --sourcefile --source out/thorium/Chromium.app --target "out/thorium/Chromium_MacOS.dmg" --volname Chromium --symlink /Applications:/Applications --format UDBZ --verbosity 2 &&
  
printf "${GRE}.DMG Build Completed. ${YEL}Installer at //out/thorium/Chromium*.dmg\n" &&
tput sgr0
