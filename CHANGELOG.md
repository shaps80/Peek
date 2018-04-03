# Changelog

5.1.0

**[Added]**

Peek now supports a Light theme
Peek now recommends alternate values for enum types
Peek now provides a Static Library variant via Cocoapods: `pod 'PeekStatic'`
Peek now supports Carthage

**[Removed]**

Classes and functions that should never have been public have been removed

**[Fixed]**

Fixing branch name in CONTRIBUTING.md and pull_request_template.md
Lots of small refactors and optimizations thanks to @valeriyvan

5.0 (Major Release)
-

- All new design
- Unified Inspectors:
- Collapse/Expand Groups
- Nested Inspectors
- Previews
- Revamped Reporting
- Accessibilty, StackViews & More
- Removed InkKit & SwiftLayout dependencies
- and more

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

2.0 (Major Release)
-

* Absolute layout overlay
* Multiple inspectors
* Swift Support
* iOS 8.3 Support
