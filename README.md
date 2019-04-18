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

## Screenshots

### ABCIntroView

| | | | |
|-|-|-|-|
| ![abcintroview-1](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-1.png) | ![abcintroview-2](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-2.png) | ![abcintroview-3](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-3.png) | ![abcintroview-4](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-4.png) |

### Surfboard

| | |
|-|-|
| ![surfboard-1](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-5.png) | ![surfboard-2](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-6.png) |

### GHWalkThrough

| | | |
|-|-|-|
| ![ghwalkthrough-1](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-7.png) | ![ghwalkthrough-2](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-8.png) | ![ghwalkthrough-3](https://github.com/ihak/iHAKWalk/raw/master/screenshots/inspiration-9.png) |

### With Paralax

| | | |
|-|-|-|
| ![bgparalax-1](https://github.com/ihak/iHAKWalk/raw/master/screenshots/paralax-bg-1.png) | ![bgparalax-2](https://github.com/ihak/iHAKWalk/raw/master/screenshots/paralax-bg-2.png) | ![bgparalax-3](https://github.com/ihak/iHAKWalk/raw/master/screenshots/paralax-bg-3.png) |

### With Blurred Background

| |
|-|
| ![blurredbg-1](https://github.com/ihak/iHAKWalk/raw/master/screenshots/blurred.png) |

### Banner

| | |
|-|-|
| ![banner-1](https://github.com/ihak/iHAKWalk/raw/master/screenshots/banner.png) | ![banner-2](https://github.com/ihak/iHAKWalk/raw/master/screenshots/banner-tapped.png) | 


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

## Get Started
### WalkView

WalkView is one of the basic component. It takes title, description, image and their particular order in which they are shown. Everything is optional so you can initialise an instance of WalkView that only shows image, title or description or a combination of these.

```Swift
let walk = WalkView(title: "Title 1", descriptionText: "Description for title 1.", image: UIImage(named: "title1"))
```

#### Changing the order
The order of title, image and description can be changed at the time of initialization by providing the desired sequence in the sequence array. The default sequence is title, description, image. If want the default sequence, just remove the sequence attribute from the initializer.

```Swift
let walk = WalkView(title: "Title 1", descriptionText: "Description for title 1.", image: UIImage(named: "title1"), sequence: [.title, .image, .description])
```

#### Initialization with optional configuration block
Initializer also supports a configuration block that allows you to style the title, description and image as you choose.

```Swift
let walk1 = WalkView(descriptionText: "Welcome to Surfboard.", image: UIImage(named: "iPhone"), sequence: [.description, .image, .title]) { (walkView, _, description, imageView) in
    description?.font = UIFont(name: "AvenirNext-Regular", size: 17.0)
    description?.textColor = .white
    description?.layoutMargins = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
    imageView?.tintColor = .white
}
```

#### Add custom spacing between controls
By default the controls are equally separated. If you want more spacing after a particular control you can adjust it in the configuration block.

```Swift
let walk1 = WalkView(descriptionText: "Welcome to Surfboard.", image: UIImage(named: "iPhone"), sequence: [.description, .image, .title]) { (walkView, _, description, imageView) in
    walkView.addCustomSpacing(spacing: 20.0, after: description!)
}
```

#### Tap Gesture
You can execute a block of code when a user taps on a particular page using `configureTap` method.

```Swift
walk1.configureTap { (walkView) in
    let alertVC = UIAlertController(title: "Title 1", message: "View 1 tapped.", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    navigationController.present(alertVC, animated: true, completion: nil)
}
```

### BGWalkView
A view that works as a background view for individual WalkView(s) as well as for the whole component. It supports an image or a color. Also provides paralax effect and blur.

#### Initialization
Can be initialized using image or color, optional `WalkView` and optional background type.

```Swift
let walk1 = WalkView(title: "This is page 1", descriptionText: "Lorem ipsum dolor sit amet.", image: UIImage(named: "ghw-title-1"), sequence: [.image, .title, .description]) { (walkView, title, description, imageView) in
    title?.font = UIFont.boldSystemFont(ofSize: 25)
    walkView.addCustomSpacing(spacing: 20.0, after: imageView!)
    walkView.addCustomSpacing(spacing: 15.0, after: title!)
}

let milestone1 = WalkBGView(image: UIImage(named: "14"), walkView: walk1)
```

If WalkView is provided, it displays it on top of the background image. 

#### Changing Background Types
`BackgroundType` supports two values, `normal` and `parallax`. For `parallax` the image used should be of right dimensions otherwise it won’t work correctly. For further details please check the example project.

```Swift
let walk1 = WalkBGView(image: UIImage(named: "bg_wide_3"), walkView: WalkView(title: "Title 1", descriptionText: "Description for title 1.", image: UIImage(named: "title2")), type: .paralax)
```

For parallax configuration check  the summary of `initialOffset` and `parallaxDelta` variables.

#### Adding Blur Effect
Background can be blurred by calling `addBlur` method on the instance. You can configure the amount of blur you want.

```Swift
let background = WalkBGView(image: UIImage(named: "2"))
background.addBlur(style: .light)
```

#### Adding Overlay
WalkBGView also supports an overlay on the background image. Its intensity and opacity can be configured via `UIColor` parameter. If you don't provide any color, it will add an overlay with default values.

```Swift
let background = WalkBGView(image: UIImage(named: "2"))
background.addOverlay()
```

#### Configuring Tap
You can pass a block to be called when WalkBGView is tapped. 
```Swift
let background = WalkBGView(image: UIImage(named: "2"))
background.configureTap { (_) in
    let alertVC = UIAlertController(title: "Title 1", message: "View 1 tapped.", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    navigationController.present(alertVC, animated: true, completion: nil)
}

```
*⚠️Warning: If you have initialized WalkBGView using a WalkView then use WalkView’s method to call the block since WalkBGView will be obscured by the WalkView.*

### WalkSlider
A view that takes WalkView and WalkBGView and layout the slider accordingly. WalkSlider identifies different views as milestones.

#### Initialization

Initializer takes an optional `WalkBGView` as background view and an array of either `WalkView(s)` or `WalkBGView(s)`. If you want a fixed background for every view, then you can provide the background and an array of `WalkView` instances.  But if you want separate backgrounds then create `WalkBGView(s)` initializing them with `WalkView` objects.

```Swift
// Initialize WalkView(s)
let walk1 = WalkView(descriptionText: "Welcome to Surfboard.", image: UIImage(named: "iPhone")) { (walkView, _, description, imageView)
        
let walk2 = WalkView(descriptionText: "Surfboard makes it delightfully easy to craft onboarding experiences.", image: UIImage(named: "surfer"))

let walk3 = WalkView(descriptionText: "You provide an array of panels and Surfboard figures out the rest.", image: UIImage(named: "panels"))
        
let walk4 = WalkView(descriptionText: "See the documentation on GitHub for more information.", image: UIImage(named: "github"))
        
let walk5 = WalkView(descriptionText: "If you like Surfboard give me a shoutout on Twitter. I'm @bermaniasstudios.", image: UIImage(named: "twitter"))

// Initialize WalkBGView that will be used as the slider background.
let bgView = WalkBGView(color: UIColor(red: 12.0/256.0, green: 18.0/256.0, blue: 148.0/256.0, alpha: 1.0))

// Finally initialize the WalkSlider with background and milestones.
let walkslider = WalkSlider(backgroundView: bgView, milestones: [walk1, walk2, walk3, walk4, walk5])
```

#### Adding Skip and PageControl

Skip button and page control are optional. You can add them and also hide them as desired. 

```Swift
walkslider.addSkipButton()
walkslider.addPageControl()
```

#### Configuring Skip and PageControl
Both components can be configured using their respective configure methods.

```Swift
walkSlider.configureSkipButton { (button) in
    button.backgroundColor = UIColor(red: 0.129, green: 0.588, blue: 0.953, alpha: 1.0)
    button.setTitle("Let's Go", for: .normal)
    button.contentEdgeInsets = .init(top: 10.0, left: 30.0, bottom: 10.0, right: 30.0)
    button.layer.cornerRadius = 5.0
    button.widthAnchor.constraint(equalTo: walkSlider.widthAnchor).isActive = true
    button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.15).isActive = true
}

walkSlider.configurePageControl { (pageControl) in
    pageControl.currentPageIndicatorTintColor = UIColor(red: 0.129, green: 0.588, blue: 0.953, alpha: 1.0)
}

```

### WalkVC
`WalkVC` is a convenience UIViewController that takes `WalkSlider` object. Can be added as a child controller or as a root view controller in a navigation. WalkSlider can be used directly if you want to add it as a view. But if you want to present it in a navigation WalkVC is a handy wrapper class to display it.

```Swift
let walkVC = WalkVC(walkSlider: walkSlider)
let navigationController = UINavigationController(rootViewController: walkVC)
navigationController.isNavigationBarHidden = true
self.present(navigationController, animated: true , completion: nil)
```

## Author

Hassan Ahmed Khan, hassandotahmed@gmail.com

## License

iHAKWalk is available under the MIT license. See the [LICENSE](/LICENSE) file for more info.
