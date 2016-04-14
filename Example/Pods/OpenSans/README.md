OpenSans
========

[![Build Status](https://travis-ci.org/CocoaPods-Fonts/OpenSans.svg?branch=master)](https://travis-ci.org/CocoaPods-Fonts/OpenSans)

Open Sans is a humanist sans serif typeface designed by Steve Matteson, Type
Director of Ascender Corp. This version contains the complete 897 character
set, which includes the standard ISO Latin 1, Latin CE, Greek and Cyrillic
character sets. Open Sans was designed with an upright stress, open forms and a
neutral, yet friendly appearance. It was optimized for print, web, and mobile
interfaces, and has excellent legibility characteristics in its letterforms.

![](http://cl.ly/image/1A1z1J3y3G2A/opensans-ios7-iphone5.png)

## Usage

```objective-c
#import <OpenSans/UIFont+OpenSans.h>

@implementation OpenSansViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.openSansLabel.font = [UIFont openSansFontOfSize:18.0f];
    self.openSansItalicLabel.font = [UIFont openSansItalicFontOfSize:18.0f];
    self.openSansLightLabel.font = [UIFont openSansLightFontOfSize:18.0f];
    self.openSansLightItalicLabel.font = [UIFont openSansLightItalicFontOfSize:18.0f];
    self.openSansBoldLabel.font = [UIFont openSansBoldFontOfSize:18.0f];
    self.openSansBoldItalicLabel.font = [UIFont openSansBoldItalicFontOfSize:18.0f];
    self.openSansSemiBoldLabel.font = [UIFont openSansSemiBoldFontOfSize:18.0f];
    self.openSansSemiBoldItalicLabel.font = [UIFont openSansSemiBoldItalicFontOfSize:18.0f];
    self.openSansExtraBoldLabel.font = [UIFont openSansExtraBoldFontOfSize:18.0f];
    self.openSansExtraBoldItalicLabel.font = [UIFont openSansExtraBoldItalicFontOfSize:18.0f];
}

@end
```

## Installation

This is a CocoaPod and you can install it with the following:

```ruby
pod 'OpenSans'
```

## License

[Steve Matteson](https://profiles.google.com/107777320916704234605) owns the
copyright to the OpenSans font and it is licensed under
[Apache License, Version 2.0](LICENSE).

