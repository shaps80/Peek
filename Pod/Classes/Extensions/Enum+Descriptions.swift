/*
 Copyright © 23/04/2016 Shaps
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

extension UILayoutConstraintAxis: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .horizontal: return "Horizontal"
        case .vertical: return "Vertical"
        }
    }
    
}

extension UIStackViewDistribution: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .equalCentering: return "Equal Centering"
        case .equalSpacing: return "Equal Spacing"
        case .fill: return "Fill"
        case .fillEqually: return "Fill Equally"
        case .fillProportionally: return "Fill Proportionally"
        }
    }
    
}

extension UIStackViewAlignment: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .center: return "Center"
        case .fill: return "Fill"
        case .firstBaseline: return "First Baseline"
        case .lastBaseline: return "Last Baseline"
        case .leading: return "Leading"
        case .trailing: return "Trailing"
        }
    }
    
}

extension UISplitViewControllerDisplayMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .allVisible: return "All Visible"
        case .automatic: return "Automatic"
        case .primaryHidden: return "Primary Hidden"
        case .primaryOverlay: return "Primary Overlay"
        }
    }
    
}

@available(iOS 11.0, *)
extension UISplitViewControllerPrimaryEdge: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .leading: return "Leading"
        case .trailing: return "Trailing"
        }
    }
    
}

extension NSLayoutRelation: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .equal: return "Equal"
        case .greaterThanOrEqual: return "Greater or Equal"
        case .lessThanOrEqual: return "Less or Equal"
        }
    }
    
}

extension NSLayoutAttribute: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .lastBaseline: return "Baseline"
        case .bottom: return "Bottom"
        case .bottomMargin: return "Bottom Margin"
        case .centerX: return "Center X"
        case .centerXWithinMargins: return "Center X with Margin"
        case .centerY: return "Center Y"
        case .centerYWithinMargins: return "Center Y with Margin"
        case .firstBaseline: return "First Baseline"
        case .height: return "Height"
        case .leading: return "Leading"
        case .leadingMargin: return "Leading Margin"
        case .left: return "Left"
        case .leftMargin: return "Left Margin"
        case .notAnAttribute: return "Not an Attribute"
        case .right: return "Right"
        case .rightMargin: return "Right Margin"
        case .top: return "Top"
        case .topMargin: return "Top Margin"
        case .trailing: return "Trailing"
        case .trailingMargin: return "Trailing Margin"
        case .width: return "Width"
        }
    }
    
}

extension UIProgressViewStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .bar: return "Bar"
        case .default: return "Default"
        }
    }
    
}

extension UIActivityIndicatorViewStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .gray: return "Small Gray"
        case .white: return "Small White"
        case .whiteLarge: return "Large White"
        }
    }
    
}

extension UIDatePickerMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .countDownTimer: return "Count Down Timer"
        case .date: return "Date"
        case .dateAndTime: return "Date and Time"
        case .time: return "Time"
        }
    }
    
}

extension UIBarButtonItemStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .bordered: return "Bordered"
        case .done: return "Done"
        case .plain: return "Plain"
        }
    }
    
}

extension UIBarButtonSystemItem: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .action: return "Action"
        case .add: return "Add"
        case .bookmarks: return "Bookmarks"
        case .camera: return "Camera"
        case .cancel: return "Cancel"
        case .compose: return "Compose"
        case .done: return "Done"
        case .edit: return "Edit"
        case .fastForward: return "Fast Forward"
        case .fixedSpace: return "Fixed Space"
        case .flexibleSpace: return "Flexibe Space"
        case .organize: return "Organize"
        case .pageCurl: return "Page Curl"
        case .pause: return "Pause"
        case .play: return "Play"
        case .redo: return "Redo"
        case .refresh: return "Refresh"
        case .reply: return "Reply"
        case .rewind: return "Rewind"
        case .save: return "Save"
        case .search: return "Search"
        case .stop: return "Stop"
        case .trash: return "Trash"
        case .undo: return "Undo"
        }
    }
    
}

extension UIBarStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .black: return "Black"
        case .blackTranslucent: return "Black Translucent"
        case .default: return "Default"
        }
    }
    
}

extension UITextFieldViewMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .always: return "Always"
        case .never: return "Never"
        case .unlessEditing: return "Unless Editing"
        case .whileEditing: return "While Editing"
        }
    }
    
}

extension UITextBorderStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .bezel: return "Bezel"
        case .line: return "Line"
        case .none: return "None"
        case .roundedRect: return "Rounded Rect"
        }
    }
    
}

extension UIImageOrientation: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .down: return "Down"
        case .downMirrored: return "Down Mirrored"
        case .left: return "Left"
        case .leftMirrored: return "Left Mirrored"
        case .right: return "Right"
        case .rightMirrored: return "Right Mirrored"
        case .up: return "Up"
        case .upMirrored: return "Up Mirrored"
        }
    }
    
}

extension UIImageResizingMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .stretch: return "Stretch"
        case .tile: return "Tile"
        }
    }
    
}

extension UIImageRenderingMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .alwaysOriginal: return "Original"
        case .alwaysTemplate: return "Template"
        case .automatic: return "Automatic"
        }
    }
    
}

extension UIStatusBarStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .lightContent: return "Light Content"
        default: return "Default"
        }
    }
    
}

extension UIStatusBarAnimation: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .fade: return "Fade"
        case .none: return "None"
        case .slide: return "Slide"
        }
    }
    
}

extension UIModalTransitionStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .coverVertical: return "Cross Vertical"
        case .crossDissolve: return "Cross Dissolve"
        case .flipHorizontal: return "Flip Horizontal"
        case .partialCurl: return "Partial Curl"
        }
    }
    
}

extension UIModalPresentationStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .currentContext: return "Current Context"
        case .custom: return "Custom"
        case .formSheet: return "Form Sheet"
        case .fullScreen: return "Full Screen"
        case .none: return "None"
        case .overCurrentContext: return "Over Current Context"
        case .overFullScreen: return "Over Full Screen"
        case .pageSheet: return "Page Sheet"
        case .popover: return "Popover"
        case .blurOverFullScreen: return "Blur Over Full Screen"
        }
    }
    
}

extension UIControlContentVerticalAlignment: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .bottom: return "Bottom"
        case .center: return "Center"
        case .fill: return "Fill"
        case .top: return "Top"
        }
    }
    
}

extension UIControlContentHorizontalAlignment: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .left: return "Left"
        case .center: return "Center"
        case .fill: return "Fill"
        case .right: return "Right"
        case .leading: return "Leading"
        case .trailing: return "trailing"
        }
    }
    
}

extension UIButtonType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .custom: return "Custom"
        case .contactAdd: return "Add Contact"
        case .detailDisclosure: return "Detail Disclosure"
        case .infoDark: return "Info Dark"
        case .infoLight: return "Info Light"
        case .system: return "System"
        case .plain: return "Plain"
        }
    }
    
}

extension UIDeviceBatteryState: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .charging: return "Charging"
        case .full: return "Full"
        case .unknown: return "Unknown"
        case .unplugged: return "Unplugged"
        }
    }
    
}

extension UIInterfaceOrientation: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .landscapeLeft: return "Left"
        case .landscapeRight: return "Right"
        case .portrait: return "Portrait"
        case .portraitUpsideDown: return "Upside Down"
        case .unknown: return "Unknown"
        }
    }
    
}

extension UIViewContentMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .left: return "Left"
        case .right: return "Right"
        case .top: return "Top"
        case .bottom: return "Bottom"
        case .bottomLeft: return "BottomLeft"
        case .bottomRight: return "BottomRight"
        case .center: return "Center"
        case .topLeft: return "Top Left"
        case .topRight: return "Top Right"
        case .redraw: return "Redraw"
        case .scaleAspectFill: return "Scale Aspect Fill"
        case .scaleToFill: return "Scale to Fill"
        case .scaleAspectFit: return "Scale Aspect Fit"
        }
    }
    
}

extension UIViewTintAdjustmentMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .automatic: return "Automatic"
        case .dimmed: return "Dimmed"
        case .normal: return "Normal"
        }
    }
    
}

extension NSLineBreakMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .byCharWrapping: return "Character Wrap"
        case .byClipping: return "Clipped"
        case .byTruncatingHead: return "Truncate Head"
        case .byTruncatingMiddle: return "Truncate Middle"
        case .byTruncatingTail: return "Truncate Tail"
        case .byWordWrapping: return "Word Wrap"
        }
    }
    
}

extension NSTextAlignment: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .center: return "Center"
        case .justified: return "Justified"
        case .left: return "Left"
        case .natural: return "Natural"
        case .right: return "Right"
        }
    }
    
}

extension UIScrollViewIndicatorStyle: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .black: return "Black"
        case .default: return "Default"
        case .white: return "White"
        }
    }
    
}

extension UIScrollViewKeyboardDismissMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .interactive: return "Interactive"
        case .none: return "None"
        case .onDrag: return "On Drag"
        }
    }
    
}
