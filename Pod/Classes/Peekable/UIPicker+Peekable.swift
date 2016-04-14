//
//  UIDatePicker+Peekable.swift
//  Peek
//
//  Created by Shaps Mohsenin on 10/04/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

extension UIPickerView {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Behaviour") { (config) in
      config.addProperties([ "showsSelectionIndicator" ])
    }
  }
  
}

extension UIDatePicker {
  
  public override func preparePeek(context: Context) {
    super.preparePeek(context)
    
    context.configure(.Attributes, "Date") { (config) in
      config.addProperties([ "minimumDate", "maximumDate", "date" ])
    }
    
    context.configure(.Attributes, "Timer") { (config) in
      config.addProperties([ "countDownDuration", "minuteInterval" ])
    }
    
    context.configure(.Attributes, "Appearance") { (config) in
      config.addProperty("datePickerMode", displayName: "Mode", cellConfiguration: { (cell, view, value) in
        if let mode = UIDatePickerMode(rawValue: value as! Int) {
          cell.detailTextLabel?.text = mode.description
        }
      })
    }
  }
  
}