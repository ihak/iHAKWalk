# iHAKWalk

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

## Overview

A customisable walkthrough view built on Swift that can be used for app intros or banners and sliders. 

## Features

- Highly customisable
- Supports full screen walkthrough as well as of any other size.
- Supports single background for complete walkthrough or different backgrounds for every single view.
- Supports colored background as well.
- Supports background parallax.
- Can be displayed using built-in VC or can be directly added in any of your own view.

## Inspiration

This project drives its inspiration from several other wonderful projects present on GitHub. Most of the projects that I explored were written in Obj-C and were very old. So I wrote this project in Swift and tried to incoporate all the good features of them.

* [ABCIntroView](https://github.com/AdamBCo/ABCIntroView)
* [Surfboard](https://github.com/MosheBerman/Surfboard)
* [GHWalkThrough](https://github.com/GnosisHub/GHWalkThrough)

## Example Project

Example project contains a list of various types of intro views aka walks or walkthroughs. This list also contains walkthroughs inpired by various github projects and are listed in the [inspiration section](#inspiration).

## Requirements

- iOS 11.4 or any higher version.
- Xcode 9 or any higher version.
- Swift 4.0 or any higher version.
- The library has not been tested with iOS 8.x.y or a lower version.

## Installation

- iHAKWalk is compatible with Swift 4.2 as of release *0.0.4*. 

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate iHAKWalk into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/ihak/iHAKPodSpecs.git'
platform :ios, '11.4'
use_frameworks!

pod 'iHAKWalk'
```

Then, run the following command:

```bash
$ pod install
```

## Author

Hassan Ahmed Khan, hassandotahmed@gmail.com

## License

iHAKWalk is available under the MIT license. See the [LICENSE](/LICENSE) file for more info.
