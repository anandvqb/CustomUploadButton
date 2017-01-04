# CustomUploadButton

[![Version](https://img.shields.io/cocoapods/v/CustomUploadButton.svg?style=flat)](http://cocoapods.org/pods/CustomUploadButton)
[![License](https://img.shields.io/cocoapods/l/CustomUploadButton.svg?style=flat)](http://cocoapods.org/pods/CustomUploadButton)
[![Platform](https://img.shields.io/cocoapods/p/CustomUploadButton.svg?style=flat)](http://cocoapods.org/pods/CustomUploadButton)

## Overview
This is a custom upload button that shows animation during the upload action. The user can stop the animation when the upload process is complete. There is also option for disabling/enabling the button.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* Xcode 8.1+
* iOS 8.0+
* Swift 3.0+

## Installation

CustomUploadButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CustomUploadButton"
```

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
