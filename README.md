<a href="https://vimeo.com/98871620"><img src="http://shaps.me/assets/img/peek-vid.jpg" name="Peek on Vimeo"/>
<br />
<br />

<img src="http://shaps.me/assets/img/blog/thumbs/peek.png" />

# Planned Updates

* Slack Integration (post issues to a Slack channel)
* Image crop indicators
*

#Peek

Peek is an open source library that lets you easily and efficiently test your application against your user interface's specification guide. <br />
Peek can be used by designers and testers, allowing developers to spend more time on code and less time testing that fonts, colors and layout are pixel perfect.

# Usage

Peek was designed to be extremely easy to use. 

# About Peek

1. Peek doesn't require any code to get started -- While your app is running just press one of the volume keys
2. Peek is automatically disabled for release builds
3. No 3rd party code or libraries are used in Peek
4. Peek never interferes with your apps normal behavior, gestures or layout
5. Peek supports all orientations and devices.

*Note: Peek will automatically disable itself for builds that do not define DEBUG.*

#Where can I download Peek?

<img src="http://shaps.me/assets/img/blog/peek-inspectors.jpg" />

Peek is not yet available as its currently in development. There is no defined release date however it will be open sourced at some point as a Cocoapod.

# How does Peek work?

Peek scans all the views in your entire view hierarchy that is currently on the screen then overlays these views with layout information.

Peek then uses its filtering system to best determine which views you care about and those that you are not likely to be interested in.

For example, by default Peek will not show you many of Apple's system components unless they are subclassed. A label however is a perfect exception to this, where you might not want to see all labels in a tab-bar but you do want to see the labels inside a cell.

Peek presents itself in its own window that sits directly on top of your own app's user interface to ensure that it doesn't interfere with normal functionality.

Peek also allows you to test all supported orientations on both iPhone and iPad.

# How do I see more information from Peek?

Double-tap anywhere on the screen to bring up the Peek Inspectors. Here peek will show you contextual information about the view you're inspecting. For example, a label will show information such as `font` and `textColor`, whereas an image might show information about its `size` or `contentMode`.

For quick access to color hex values, you can also tap-and-hold anywhere on the screen while Peek is active, to bring up the color loupe. Drag your finger over the screen to show HEX color values of anything under the loupe.

Peek also supports multiple overlay modes for providing absolute layout or relative spacing.


# Attribution

Original concept, code and app design by [@shaps][shaps]<br />
Icon design by [@h1brd][marco]

[github]: https://github.com/shaps80/Peek
[docs]: http://no_docs_url_yet
[shaps]: http://twitter.com/shaps "Shaps on Twitter"
[marco]: http://twitter.com/h1brd "Marco on Twitter"
