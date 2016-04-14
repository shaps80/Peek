//
//  Enum+Descriptions.swift
//  Peek
//
//  Created by Shaps Mohsenin on 24/03/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension NSLayoutRelation: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Equal: return "Equal"
    case .GreaterThanOrEqual: return "Greater or Equal"
    case .LessThanOrEqual: return "Less or Equal"
    }
  }
  
}

extension NSLayoutAttribute: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Baseline: return "Baseline"
    case .Bottom: return "Bottom"
    case .BottomMargin: return "Bottom Margin"
    case .CenterX: return "Center X"
    case .CenterXWithinMargins: return "Center X with Margin"
    case .CenterY: return "Center Y"
    case .CenterYWithinMargins: return "Center Y with Margin"
    case .FirstBaseline: return "First Baseline"
    case .Height: return "Height"
    case .Leading: return "Leading"
    case .LeadingMargin: return "Leading Margin"
    case .Left: return "Left"
    case .LeftMargin: return "Left Margin"
    case .NotAnAttribute: return "Not an Attribute"
    case .Right: return "Right"
    case .RightMargin: return "Right Margin"
    case .Top: return "Top"
    case .TopMargin: return "Top Margin"
    case .Trailing: return "Trailing"
    case .TrailingMargin: return "Trailing Margin"
    case .Width: return "Width"
    }
  }
  
}

extension UIProgressViewStyle: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Bar: return "Bar"
    case .Default: return "Default"
    }
  }
  
}

extension UIActivityIndicatorViewStyle: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Gray: return "Small Gray"
    case .White: return "Small White"
    case .WhiteLarge: return "Large White"
    }
  }
  
}

extension UIDatePickerMode: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .CountDownTimer: return "Count Down Timer"
    case .Date: return "Date"
    case .DateAndTime: return "Date and Time"
    case .Time: return "Time"
    }
  }
  
}

extension UIBarButtonItemStyle: CustomStringConvertible {
 
  public var description: String {
    switch self {
    case .Bordered: return "Bordered"
    case .Done: return "Done"
    case .Plain: return "Plain"
    }
  }
  
}

extension UIBarButtonSystemItem: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Action: return "Action"
    case .Add: return "Add"
    case .Bookmarks: return "Bookmarks"
    case .Camera: return "Camera"
    case .Cancel: return "Cancel"
    case .Compose: return "Compose"
    case .Done: return "Done"
    case .Edit: return "Edit"
    case .FastForward: return "Fast Forward"
    case .FixedSpace: return "Fixed Space"
    case .FlexibleSpace: return "Flexibe Space"
    case .Organize: return "Organize"
    case .PageCurl: return "Page Curl"
    case .Pause: return "Pause"
    case .Play: return "Play"
    case .Redo: return "Redo"
    case .Refresh: return "Refresh"
    case .Reply: return "Reply"
    case .Rewind: return "Rewind"
    case .Save: return "Save"
    case .Search: return "Search"
    case .Stop: return "Stop"
    case .Trash: return "Trash"
    case .Undo: return "Undo"
    }
  }
  
}

extension UIBarStyle: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Black: return "Black"
    case .BlackTranslucent: return "Black Translucent"
    case .Default: return "Default"
    }
  }
  
}

extension UITextFieldViewMode: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Always: return "Always"
    case .Never: return "Never"
    case .UnlessEditing: return "Unless Editing"
    case .WhileEditing: return "While Editing"
    }
  }
  
}

extension UITextBorderStyle: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Bezel: return "Bezel"
    case .Line: return "Line"
    case .None: return "None"
    case .RoundedRect: return "Rounded Rect"
    }
  }
  
}

extension UIImageOrientation: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Down: return "Down"
    case .DownMirrored: return "Down Mirrored"
    case .Left: return "Left"
    case .LeftMirrored: return "Left Mirrored"
    case .Right: return "Right"
    case .RightMirrored: return "Right Mirrored"
    case .Up: return "Up"
    case .UpMirrored: return "Up Mirrored"
    }
  }
  
}

extension UIImageResizingMode: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Stretch: return "Stretch"
    case .Tile: return "Tile"
    }
  }
  
}

extension UIImageRenderingMode: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .AlwaysOriginal: return "Original"
    case .AlwaysTemplate: return "Template"
    case .Automatic: return "Automatic"
    }
  }
  
}

extension UIStatusBarStyle: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .LightContent: return "Light Content"
    default: return "Default"
    }
  }
  
}

extension UIStatusBarAnimation: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Fade: return "Fade"
    case .None: return "None"
    case .Slide: return "Slide"
    }
  }
  
}

extension UIModalTransitionStyle: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .CoverVertical: return "Cross Vertical"
    case .CrossDissolve: return "Cross Dissolve"
    case .FlipHorizontal: return "Flip Horizontal"
    case .PartialCurl: return "Partial Curl"
    }
  }
  
}

extension UIModalPresentationStyle: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .CurrentContext: return "Current Context"
    case .Custom: return "Custom"
    case .FormSheet: return "Form Sheet"
    case .FullScreen: return "Full Screen"
    case .None: return "None"
    case .OverCurrentContext: return "Over Current Context"
    case .OverFullScreen: return "Over Full Screen"
    case .PageSheet: return "Page Sheet"
    case .Popover: return "Popover"
    }
  }
  
}

extension UIControlContentVerticalAlignment: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Bottom: return "Bottom"
    case .Center: return "Center"
    case .Fill: return "Fill"
    case .Top: return "Top"
    }
  }
  
}

extension UIControlContentHorizontalAlignment: CustomStringConvertible {
 
  public var description: String {
    switch self {
    case .Left: return "Left"
    case .Center: return "Center"
    case .Fill: return "Fill"
    case .Right: return "Right"
    }
  }
  
}

extension UIButtonType: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Custom: return "Custom"
    case .ContactAdd: return "Add Contact"
    case .DetailDisclosure: return "Detail Disclosure"
    case .InfoDark: return "Info Dark"
    case .InfoLight: return "Info Light"
    case .System: return "System"
    }
  }
  
}

extension UIDeviceBatteryState: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Charging: return "Charging"
    case .Full: return "Full"
    case .Unknown: return "Unknown"
    case .Unplugged: return "Unplugged"
    }
  }
  
}

extension UIInterfaceOrientation: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .LandscapeLeft: return "Left"
    case .LandscapeRight: return "Right"
    case .Portrait: return "Portrait"
    case .PortraitUpsideDown: return "Upside Down"
    case .Unknown: return "Unknown"
    }
  }
  
}

extension UIViewContentMode: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Left: return "Left"
    case .Right: return "Right"
    case .Top: return "Top"
    case .Bottom: return "Bottom"
    case .BottomLeft: return "BottomLeft"
    case .BottomRight: return "BottomRight"
    case .Center: return "Center"
    case .TopLeft: return "Top Left"
    case .TopRight: return "Top Right"
    case .Redraw: return "Redraw"
    case .ScaleAspectFill: return "Scale Aspect Fill"
    case .ScaleToFill: return "Scale to Fill"
    case .ScaleAspectFit: return "Scale Aspect Fit"
    }
  }
  
}

extension UIViewTintAdjustmentMode: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Automatic: return "Automatic"
    case .Dimmed: return "Dimmed"
    case .Normal: return "Normal"
    }
  }
  
}

extension NSLineBreakMode: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .ByCharWrapping: return "Character Wrap"
    case .ByClipping: return "Clipped"
    case .ByTruncatingHead: return "Truncate Head"
    case .ByTruncatingMiddle: return "Truncate Middle"
    case .ByTruncatingTail: return "Truncate Tail"
    case .ByWordWrapping: return "Word Wrap"
    }
  }
  
}

extension NSTextAlignment: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Center: return "Center"
    case .Justified: return "Justified"
    case .Left: return "Left"
    case .Natural: return "Natural"
    case .Right: return "Right"
    }
  }
  
}

extension UIScrollViewIndicatorStyle: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Black: return "Black"
    case .Default: return "Default"
    case .White: return "White"
    }
  }
  
}

extension UIScrollViewKeyboardDismissMode: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .Interactive: return "Interactive"
    case .None: return "None"
    case .OnDrag: return "On Drag"
    }
  }
  
}

