# GraphicsRenderer

[![Version](https://img.shields.io/cocoapods/v/GraphicsRenderer.svg?style=flat)](http://cocoapods.org/pods/GraphicsRenderer)
[![License](https://img.shields.io/cocoapods/l/GraphicsRenderer.svg?style=flat)](http://cocoapods.org/pods/GraphicsRenderer)
[![Language](https://img.shields.io/badge/language-swift_3.0-ff69b4.svg)](http://cocoadocs.org/docsets/GraphicsRenderer)
[![Platform](https://img.shields.io/cocoapods/p/GraphicsRenderer.svg?style=flat)](http://cocoapods.org/pods/GraphicsRenderer)

## Introduction

<img src="sample.png" />

GraphicsRenderer is designed to a drop-in UIGraphicsRenderer port. For this reason, all function names are matched to make it easy to swap out a later date.

```swift
UIGraphicsRendererFormat > RendererFormat
UIGraphicsImageRendererFormat > ImageRendererFormat
UIGraphicsPDFRendererFormat > PDFRendererFormat

UIGraphicsRendererContext > RendererContext
UIGraphicsImageRendererContext > ImageRendererContext
UIGraphicsPDFRendererContext > PDFRendererContext
```

The classes you'll mostly work with though are:

```swift
UIGraphicsRenderer > Renderer
UIGraphicsImageRenderer > ImageRenderer
UIGraphicsPDFRenderer > PDFRenderer
```

GraphicsRenderer is also cross-platform with iOS and macOS demo projects included in the repo.

GraphicsRenderer matches the entire API currently available from UIGraphicsRenderer, however to make it work nicely with all platforms, it also includes some additional convenience's, like `flipping` the `context`. 

GraphicsRenderer is also protocol based, which makes it more Swifty and allows for some nice generics driven integration as you can see in the `performDrawing()` example.

## InkKit

I have another library called <a href="http://github.com/shaps80/InkKit">InkKit</a> which now uses this library for its inner workings. For a LOT more drawing and layout convenience's -- checkout that library too.~~

Note: If you include InkKit in your project, you don't need to include this project too.

## Example

There are 2 example projects included in the repo. One for iOS and another for OSX.

Simply select the appropriate scheme, build and run.

Lets start by creating a simple drawing function:

```swift
func performDrawing<Context: RendererContext>(context: Context) {
	let rect = context.format.bounds
    UIColor.white.setFill()
    context.fill(rect)
    
    UIColor.blue.setStroke()
    let frame = CGRect(x: 10, y: 10, width: 40, height: 40)
    context.stroke(frame)
    
    UIColor.red.setStroke()
    context.stroke(rect.insetBy(dx: 5, dy: 5))
}
```

Now lets create an image from this drawing:

```swift
let image = ImageRenderer(size: CGSize(width: 100, height: 100)).image { context in
	performDrawing()
}
```

Or perhaps you'd prefer a PDF?

```swift
let bounds = CGRect(x: 0, y: 0, width: 612, height: 792)
try? PDFRenderer(bounds: bounds).writePDF(to: url) { context in
    context.beginPage()
    performDrawing(context: context)
    context.beginPage()
    performDrawing(context: context)
}
```

## Drawing

When working with PDFs you don't need to worry about creating the PDF, ending pages or even closing the PDF. This is all handled automatically for you.

The `context` returned to you inside the drawing block holds onto 2 key pieces of information. (Just like `UIGraphicsRendererContext`)

`format` -- Provides information about bounds, scale, etc..
`cgContext` --  The underlying `CGContext`

Final note, the `stroke` methods are optimized to work the same way as the Apple implementation, in that they automatically insetBy 0.5 for you. If you don't want this behavious automatically, simply use the usual methods available on `CGContext`. 

e.g. `cgContext.stroke(rect: myRect)`

## Requirements

The library has the following requirements:

* Swift 3.0
* iOS 8.0+
* OSX 10.10+

## Installation

GraphicsRenderer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GraphicsRenderer"
```

## Author

Shaps Benkau, shapsuk@me.com

## License

GraphicsRenderer is available under the MIT license. See the LICENSE file for more info.
