@echo off
clang -target x86_64-apple-darwin ^
      -isysroot C:\MacOSX10.15.sdk ^
      -mmacosx-version-min=10.10 ^
      -fuse-ld=lld ^
      -framework Cocoa ^
      AppDelegate.m main.m ^
      -o HelloWorldApp.app/Contents/MacOS/HelloWorldApp
