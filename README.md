# CustomUploadButton

[![Version](https://img.shields.io/cocoapods/v/CustomUploadButton.svg?style=flat)](http://cocoapods.org/pods/CustomUploadButton)
[![License](https://img.shields.io/cocoapods/l/CustomUploadButton.svg?style=flat)](http://cocoapods.org/pods/CustomUploadButton)
[![Platform](https://img.shields.io/cocoapods/p/CustomUploadButton.svg?style=flat)](http://cocoapods.org/pods/CustomUploadButton)

## Overview
This is a custom upload button that shows animation during the upload action. The user can stop the animation when the upload process is complete. There is also option for disabling/enabling the button.

<p align="center">
<img src="http://i.imgur.com/mTBHWEg.gif" alt="CustomUploadButton" />
</p>

## Requirements
* Xcode 8.1+
* iOS 8.0+
* Swift 3.0+

## Installation

### CocoaPods:

CustomUploadButton is available through [CocoaPods](http://cocoapods.org). [CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate `CustomUploadButton` into your Xcode project using CocoaPods, specify it in your Podfile:
```ruby

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
pod ’CustomUploadButton’, ‘1.0.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Manually:

* Download CustomUploadButton.
* Drag and drop CustomUploadButton directory to your project

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

##Usage

Here is how you can use `CustomUploadButton`. 

Import CustomUploadButton to your viewcontroller,

```swift
import CustomUploadButton
```

Then create an instance of the CustomUploadButton and set the delegate as follows:

```swift
@IBOutlet weak var uploadButton: CustomUploadButton!

uploadButton.delegate = self
```

Now, implement the `CustomUploadButtonActionDelegate` function where you can stop the animation when your task is complete:

```swift
public func buttonAction(sender: CustomUploadButton) {
    
    //Your task here
    
    if sender == uploadButton {
        sender.stopAnimation()
    }
}
```

## Author

Anand V, anandv@qburst.com

## License

CustomUploadButton is available under the MIT license. See the LICENSE file for more info.
