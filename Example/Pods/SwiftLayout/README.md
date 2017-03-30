<img src="assets/logo.png" width="100">

# SwiftLayout

[![Version](https://img.shields.io/cocoapods/v/SwiftLayout.svg?style=flat)](http://cocoapods.org/pods/SwiftLayout)
[![License](https://img.shields.io/cocoapods/l/SwiftLayout.svg?style=flat)](http://cocoapods.org/pods/SwiftLayout)
[![Platform](https://img.shields.io/cocoapods/p/SwiftLayout.svg?style=flat)](http://cocoapods.org/pods/SwiftLayout)

#### Note
By default Swift Layout is now using Swift 3.0. You can install either 3.0 or 2.2 version as follows:

Swift 3.0  
`pod 'SwiftLayout'`  

Swift 2.3 - **Not Supported**

Swift 2.2  
`pod 'SwiftLayout', '1.3.1'`

---

Often we have to use AutoLayout in our apps. In fact sometimes, we can't even use Interface Builder. Which means we need to add these programmatically.

I had previously done this manually, even occassionally used a 3rd party lib/pod. There are some great libs out there, but I wanted to build my own. Both for my own understanding and also to provide a cleaner interface that made programmatic AutoLayout easy.

__Introducing SwiftLayout__

```swift
import SwiftLayout

class ViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()

      let views = [ addView(), addView(), addView() ]
	  views.distribute(along: .vertical, in: view)
	  views.size(width: 100, height: 50)
	  views.align(axis: .horizontal, in: view)

      let label = UILabel()
      view.addSubview(label)
      label.pin(edge: .Left, to: .Right, of: view, margin: 15)
    }

}
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SwiftLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftLayout"
```

## Author

Shaps Mohsenin, shapsuk@me.com

## License

SwiftLayout is available under the MIT license. See the LICENSE file for more info.


## Attributes

Icon: Cluster by Thomas Helbig from the Noun Project
