# InkKit

[![Version](https://img.shields.io/cocoapods/v/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)
[![License](https://img.shields.io/cocoapods/l/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)
[![Language](https://img.shields.io/badge/language-swift-ff69b4.svg)](http://cocoadocs.org/docsets/InkKit)
[![Platform](https://img.shields.io/cocoapods/p/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)

## Swift Support

**Swift 4.0**

InkKit is Swift 4.0 by default, so to use that just include InkKit in your podfile:

pod 'InkKit'

**Swift 3.2**

In order to use InkKit in a Swift 3.2/3.0 project, ensure you point to the `2.1.0` tag.

`pod 'InkKit', '2.1.0'`

**Swift 2.3**

In order to use InkKit in a Swift 2.3 project, ensure you point to the `swift2.3` branch.

`pod 'InkKit', :git => 'https://github.com/shaps80/InkKit/', :branch => 'swift2.3'`

**Swift 2.2**

If you still require Swift 2.2, point your version as such:
`pod 'InkKit', '1.3.1'`

## Example Code

Everything you see here, was code-drawn with InkKit! In fact, other than some `CGRect` instances, this is ALL the code required to draw the image you see on the right ;)

<table>
  <tr>
    <th width="30%">Drawing made simple!</th>
    <th width="30%">InkKit In Action</th>
  </tr>
  <tr>
    <td>Lets draw the screen on the right.</td>
    <th rowspan="9"><img src="https://camo.githubusercontent.com/3b91556602d4501e9916903939f35d1ea85697a7/687474703a2f2f73686170732e6d652f6173736574732f696d672f626c6f672f496e6b4b69742e676966"></th>
  </tr>
  <tr><td><div class="highlight highlight-source-swift"><pre>
Draw.fillRect(bgFrame, color: UIColor(hex: "1c3d64"))
let grid = Grid(colCount: 6, rowCount: 9, bounds: gridFrame)
let path = grid.path(includeComponents: [.Columns, .Rows])

Draw.strokePath(path, startColor: UIColor(white: 1, alpha: 0.15),
    endColor: UIColor(white: 1, alpha: 0.05), angleInDegrees: 90)

let rect = grid.boundsForRange(sourceColumn: 1, sourceRow: 1,
                      destinationColumn: 4, destinationRow: 6)

drawCell(rect, title: "4x6",
  includeBorder: true, includeShadow: true)

Draw.addShadow(.Outer, path: UIBezierPath(rect: barFrame),
           color: UIColor(white: 0, alpha: 0.4), radius: 5,
                       offset: CGSize(width: 0, height: 1))

Draw.fillRect(barFrame, color: UIColor(hex: "ff0083"))

let (_, navFrame) = barFrame.divide(20, fromEdge: .MinYEdge)
"InkKit".drawAlignedTo(navFrame, attributes: [
  NSForegroundColorAttributeName: Color.whiteColor(),
  NSFontAttributeName: UIFont(name: "Avenir-Book", size: 20)!
])

backIndicatorImage().drawAtPoint(CGPoint(x: 22, y: 30))  
</pre></div></td></tr>
</table>

## Change Log

**v2.0.0**

Note: Since this is a Swift 3 release, I decided to also clean up the API and remove all deprecation warnings. InkKit 2.0 should be considered a new API.

* Swift 3.0 Support
* Updated API to support Swift 3.0 guidelines
* Shear Transforms
* Perspective Transforms
* Radians from Degrees function (and inverse)
* Corner Radius with Concave, Convex and Line support
* New Color value-type


**v1.3.1**

* OSX Support
* OSX Demo Project now included
* ~~Table~~ renamed to Grid
* ~~Table~~ renamed to GridComponents
* Added convenience methods for working with paths

**v1.2.0**

* Shadows
* Borders
* Tables

**v1.1.0**

* Images
* Strings

**v1.0**

* Fills
* Strokes
* Geometry

## API

InkKit provides many useful convenience methods for drawing and geometry calculations. Its also cross platform working across iOS & MacOS

### Core

If the convenience methods below don't solve your needs, you can start by using the new methods added directly to `CGContext` itself:

```swift
func draw(inRect:attributes:drawing:)
```

Which would look like this in usage:

```swift
CGContext.current?.draw(inRect: rect, drawing: { (context, rect, attributes) in
  Color.redColor.setFill()
  UIRectFill(rect)
})
```

This basically wraps getting the context, setting up its frame and save/restore calls. If you provide the additional DrawingAttributes block, it will also pre-configure your context with those options for you.

### Grid

```swift
init(colCount:rowCount:bounds:)
func positionForCell(atIndex:) -> (col: Int, row: Int)
func boundsForCell(atIndex:) -> CGRect
func boundsForRange(sourceColumn:sourceRow:destinationColumn:destinationRow:) -> CGRect
func boundsForCell(col:row:) -> CGRect
func enumerateCells(enumerator:(index:col:row:bounds:) -> Void)
```

A `Grid` is a really great way for laying out your drawing without having to think about placement, rect translations, etc...

I use them often for layout only, but sometimes its useful to be able to render them as well (like in the included demo).

```swift
// components is a bitmask [ .Outline, .Rows, .Columns ]
func stroke(components:attributes:)
```

### Borders & Shadows

Supports `.Outer`, `.Inner` and `.Center` borders, as well as `.Outer` and `.Inner` shadows.

```swift
static func addBorder(type:path:attributes:)
static func addShadow(type:path:color:radius:offset:)
```

### Strokes

```swift
static func strokeLine(startPoint:endPoint:startColor:endColor:angleInDegrees:attributes:)
static func strokeLine(startPoint:endPoint:color:attributes:)
static func strokePath(path:startColor:endColor:angleInDegrees:attributes:)
```


### Fills

```swift
static func fillPath(path:startColor:endColor:angleInDegrees:attributes:)
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

To try it out yourself, download the [source](http://github.com/shaps80/InkKit) and run the included demo project.

## Platforms and Versions

InkKit is supported on the following platforms:

* iOS 8.0 and greater
* OSX 10.11 and greater

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
