Purpose
--------------

SPXMasking is category on CALayer that allows you to specify different a corner radius for each corner of a CALayer.


Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 7.1
* Earliest supported deployment target - iOS 3.2


ARC Compatibility
------------------

The SPXMasking category will work correctly ONLY with ARC enabled.



Installation
--------------

To use the SPXMasking category in an app, just drag the category files into your project and import the header file into any class where you wish to make use of the SPXMasking functionality.


SPXMasking Extensions
----------------------

This method will apply a corner radius to the specified corners of the CALayer

    - (void)setCornerRadii:(SPXCornerRadii)cornerRadii;

This method is provided as a convenience for specifying corner radii

    extern SPXCornerRadii SPXCornerRadiiMake(CGFloat bottomLeft, CGFloat topLeft, CGFloat topRight, CGFloat bottomRight);
    
This method will compare two SPXCornerRadii structures and return YES if they are equal, NO otherwise

	extern bool SPXCornerRadiiEquals(SPXCornerRadii radii1, SPXCornerRadii radii2);