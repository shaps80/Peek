<a href="https://vimeo.com/162896152"><img src="shot.jpg" name="Peek on Vimeo"/></a>

[![Version](https://img.shields.io/cocoapods/v/Peek.svg?style=flat)](http://cocoapods.org/pods/Peek)
[![License](https://img.shields.io/cocoapods/l/Peek.svg?style=flat)](http://cocoapods.org/pods/Peek)
[![Language](https://img.shields.io/badge/language-swift-ff69b4.svg)](http://cocoadocs.org/docsets/Peek)
[![Platform](https://img.shields.io/cocoapods/p/Peek.svg?style=flat)](http://cocoapods.org/pods/Peek)

# Peek: All new design

Peek 4.1 with an all new design and all new features. Whether you're a developer, designer or QA/tester, Peek can help you at all stages of your development process.

## Unified Inspectors
All inspectors and attributes have now been unified into a single window, making inspection simpler and faster than ever before.

## Collapse/Expand Headers
Feeling overwhelmed with all the information Peek has to offer? Simply tap the header to expand/collapse any section. Peek will even remember your choice across launches!

## Nested Inspectors
Peek now supports nested Inspectors. This powerful feature allows Peek to surface even more detail about your application. In fact Peek 4.1 more than doubles the number of attributes it can inspect. 

## Previews
Views, images, colours and more can now provide snapshot previews to help you better identify what you’re inspecting. 

## Reporting
An all new reporting system allows you to export screenshots, metadata and even suggested values using the iOS native share sheet. 

## Less Code
Thanks to an all new architecture Peek is also now smaller. Providing more features with much less code, leaving a very small footprint on your application.

# Ready to get started?

## Designers & Testers

- Simply press one of your volume key(s) to show & hide Peek
- Now tap or drag your finger across the screen
- Tap the inspectors button (or double tap anywhere on the screen) to show the Inspectors for the selected view

You can't get simpler than that!

## Developers

### Device

The simplest way to integrate Peek into your project is to use `Cocoapods`:

```ruby
pod 'Peek', :configurations => ['Debug']
```

You only need 1 line of code to enable Peek in your application:

`window?.peek.enabled = true`

### Simulator

When running in the Simulator you'll need a couple of extra lines:

```swift
// Your AppDelegate
override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
    // iOS 8/9 requires device motion handlers to be on the AppDelegate
    window?.peek.handleShake(motion)
}
```

or 

```swift

// Your ViewController
override var canBecomeFirstResponder: Bool {
    return true
}
    
override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
    // iOS 10 now requires device motion handlers to be on a UIViewController
    view.window?.peek.handleShake(motion)
}
```

Now you can press `CMD+CTRL+Z` (or use the Menu option) to show/hide Peek in your Simulator.

# What is Peek?

Peek is an open source framework that provides runtime inspection of your application while its running on your device (or Simulator).

- Developers can use Peek to inspect their user interfaces at runtime.
- Designers can verify that the applications meets their design specifications.
- Testers and QA can check accessibility identifiers, validate behaviour and report issues.

Peek is a tool to aide you at all stages of your development process.

# How does Peek work?

Peek scans your entire user interface on the screen then provides overlays with layout information and attribute inspectors.

Peek includes an intelligent filtering system to best determine which views you care about while ignoring those you are not likely to be interested in.

For example, by default Peek will not show you many of Apple's system components unless they are subclassed.

Peek presents itself in its own window that sits directly on top of your own app's user interface to ensure that it doesn't interfere with normal functionality.

Peek also allows you to test all supported orientations on both iPhone and iPad.

Most importantly Peek doesn’t interfere with your applications logic or user interface in anyway. It provides read-only inspection to guarantee you’re seeing live-values only!

# Demo

If you're not ready to integrate Peek into your own project, You can simply download this repo and run the sample project included :)

Its a small app that perfectly demonstrates the power of Peek!

# Configuring Peek

Peek allows many options to be configured, allowing you more control over how Peek is configured as well as reporting options:

```swift
window?.peek.enableWithOptions { options in
  options.activationMode = .Auto
  options.shouldIgnoreContainers = true
  
  /*
    Sometimes it can also be useful to include additional metadata with each report.
   */
  options.metaData = [ "Environment": "UAT" ]
}
```

# Safety First

Peek is designed to be as safe as possible. Peek will never retain objects from your application. It will never use a background thread. Peek won't even run unless you explicitly enable it!

Go ahead, take a Peek at your app now :)

# How does Peek work?

Peek scans all the views in your entire view hierarchy that is currently on the screen then overlays these views with layout information.

Peek then uses its filtering system to best determine which views you care about and those that you are not likely to be interested in.

For example, by default Peek will not show you many of Apple's system components unless they are subclassed. A label however is a perfect exception to this, where you might not want to see all labels in a tab-bar but you do want to see the labels inside a cell.

Peek presents itself in its own window that sits directly on top of your own app's user interface to ensure that it doesn't interfere with normal functionality.

Peek also allows you to test all supported orientations on both iPhone and iPad.

# Supported Platforms and Versions

Peek is officially supported (and tested) with the following configurations:

- iOS 9.0+ (Swift and Objective-C)

# Swift Versions

**Swift 4.x**

This is the current release.

**Swift 3.x**

Swift 3.x unfortunately broke some of the compatilibity issues I required to work with the runtime.
Please use the Swift 4 version instead.

**Swift 2.3**

If you need Swift 2.3 support, update your Podfile as such:

`pod 'Peek', '2.3'`

**Swift 2.2**

If you need Swift 2.2 support, update your Podfile as such:

`pod 'Peek', '2.0'`

---

# Changelog

4.1
-

- All new design
- Unified Inspectors:
- Collapse/Expand Groups
- Nested Inspectors
- Previews
- Revamped Reporting

> Note: Dropped support for iOS 8.x.

4.0
-

Just a Swift compatibility update.
Minor changes as per Swift APIs but no functional changes to Peek.

3.0
-

Swift 3.x unfortunately broke some of the compatilibity issues I required to work with the runtime.
Please use the Swift 4 version instead.

2.2.0
-

* Slack integration
* Email reports
* Screenshot upload block (for Slack)
* NSAttributedString support, including paragraph styles

2.1.0
-

* Enable with options
* Force shake gesture on device
* Allow container selection

2.0
-

* Absolute layout overlay
* Multiple inspectors
* Swift Support
* iOS 8.3 Support


# Attribution

Original concept, code and app design by [@shaps][shaps]<br />

[github]: https://github.com/shaps80/Peek
[shaps]: http://twitter.com/shaps "Shaps on Twitter"
