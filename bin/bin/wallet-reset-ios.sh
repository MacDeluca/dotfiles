#!/bin/bash

echo "Resetting iOS build environment..."

echo "Killing connected usb devices"
killall -9 usbmuxd

echo "Removing DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData

echo "Removing iOS build..."
rm -rf ~/projects/bc-wallet-mobile/app/ios/build

echo "Installing npm packages..."
cd ~/projects/bc-wallet-mobile && yarn install

echo "Deintegrating and reinstalling CocoaPods..."
cd ~/projects/bc-wallet-mobile/app/ios && pod deintegrate && pod install

