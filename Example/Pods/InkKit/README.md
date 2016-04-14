<img src="Resources/icon.png" width=128 height=128 alt="InkKit Logo" />
 
# InkKit

[![Version](https://img.shields.io/cocoapods/v/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)
[![License](https://img.shields.io/cocoapods/l/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)
[![Platform](https://img.shields.io/cocoapods/p/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)

## Example

***Note: The code below will work for both iOS and OSX)***

```swift
let (leftRect, rightRect) = frame.divide(atDelta: 0.5, fromEdge: .MinXEdge, margin: 10)
let start = Color.whiteColor()
let end = Color.blackColor()
let leftPath = BezierPath(rect: leftRect)

// fill the left rect with a 90º gradient
Draw.fillPath(leftPath, startColor: start, endColor: end, angleInDegrees: 90)

// draw some text, aligned to the right rect
"InkKit is so awesome!".drawAlignedTo(rightRect, horizontal: .Center, vertical: .Middle)

// create an image of a circle (with a radius of 5pt) and draw it
Image.circle(radius: 10) { (attributes) in
  attributes.strokeColor = Color.blackColor()
  attributes.fillColor = Color.redColor().colorWithAlphaComponent(0.5)
  attributes.dashPattern = [1, 4]
  attributes.lineWidth = 2
}.drawAtPoint(CGPointMake(0, 0))
```

## Usage

InkKit provides many useful convenience methods for drawing and geometry calculations.

### Core

If the convenience methods below don't solve your needs, you can start by using the new methods added directly to `CGContext` itself:

```swift
func draw(inRect:attributes:drawing:)
```

Which would look like this in usage:

```swift
UIGraphicsGetCurrentContext()?.draw(inRect: rect, drawing: { (context, rect, attributes) in
  Color.redColor.setFill()
  CGContextFillRect(rect)
})
```

This basically wraps getting the context, setting up its frame and save/restore calls. If you provide the additional DrawingAttributes block, it will also pre-configure your context with those options for you.

### Primitives

For drawing primitives, like lines, paths, fills, strokes and gradients:

```swift
static func strokeLine(startPoint:endPoint:startColor:endColor:angleInDegrees:attributes:)
static func strokeLine(startPoint:endPoint:color:attributes:)

static func strokePath(path:startColor:endColor:angleInDegrees:attributes:)
static func fillPath(path:startColor:endColor:angleInDegrees:attributes:)

static func drawGradientPath(path:startColor:endColor:angleInDegrees:stroke:attributes:)

```

### Geometry

Many of the drawing methods use the geometry additions below, but they can also be useful for your own projects:

```swift
func divide(atDelta:fromEdge:margin:) -> (slice, remainder)
func insetBy(edgeInsets:) -> CGRect
mutating func insetInPlace(edgeInsets:)
func alignedTo(rect:horizontal:vertical:) -> CGRect
func scaledTo(rect:scaleMode:) -> CGRect

func gradientPoints(forAngleInDegrees:) -> (start, end)
func scaledTo(size:scaleMode:) -> CGSize

func reversibleRect(fromPoint:toPoint:) -> CGRect
```

### Images

There are also additional draw methods for images:

```swift
func drawAlignedTo(rect:horizontal:vertical:blendMode:alpha:)
func drawScaledTo(rect:scaleMode:blendMode:alpha:)

static func circle(radius:attributes:) -> Image
static func draw(width:height:scale:attributes:drawing:) -> Image
static func draw(size:scale:attributes:drawing:) -> Image
```

### Strings

Finally, we even have some easy draw methods for strings:

```swift
func drawAlignedTo(rect:horizontal:vertical:attributes:constrainedSize:)
func sizeWithAttributes(attributes:constrainedSize:) -> CGSize
func drawAtPoint(point:attributes:)
func drawInRect(rect:withAttributes)
```

## Demo

To see it in action, checkout the included demo project which has some UI hooked up to show its usage.

## Requirements

InkKit only depends on CoreGraphics and has no other external dependencies.

## Installation

InkKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InkKit'
```

Alternatively you can simply drag the files into your iOS or OSX project.


## Author

[@shaps](http://twitter.com/shaps)

## License

InkKit is available under the MIT license. See the LICENSE file for more info.
