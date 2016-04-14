//
//  Week.swift
//  Track
//
//  Created by Shaps Mohsenin on 09/02/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation

struct Week: Equatable, Comparable {
  
  static let NumberKey = "number"
  static let ImagePathKey = "imagePath"
  static let WeightKey = "weight"
  static let WaistKey = "waist"
  static let HipsKey = "hips"
  static let ChestKey = "chest"
  
  var number: Int
  var weight: Double?
  var waist: Double?
  var hips: Double?
  var chest: Double?
  
  init(number: Int) {
    self.number = number
  }
  
  init(fromJSON JSON: [String: AnyObject]) {
    number = JSON[Week.NumberKey] as! Int
    weight = JSON[Week.WeightKey] as? Double
    waist = JSON[Week.WaistKey] as? Double
    hips = JSON[Week.HipsKey] as? Double
    chest = JSON[Week.ChestKey] as? Double
  }
  
  func toJSON() -> [String: AnyObject] {
    var JSON = [String: AnyObject]()
    
    JSON[Week.NumberKey] = number
    JSON[Week.WeightKey] = weight
    JSON[Week.WaistKey] = waist
    JSON[Week.HipsKey] = hips
    JSON[Week.ChestKey] = chest
    
    return JSON
  }
  
  func complete() -> Bool {
    return weight != nil && hips != nil && waist != nil && chest != nil
  }
  
}

func ==(lhs: Week, rhs: Week) -> Bool {
  return lhs.number == rhs.number
}

func <(lhs: Week, rhs: Week) -> Bool {
  return lhs.number < rhs.number
}

func <=(lhs: Week, rhs: Week) -> Bool {
  return lhs.number <= rhs.number
}

func >=(lhs: Week, rhs: Week) -> Bool {
  return lhs.number >= rhs.number
}

func >(lhs: Week, rhs: Week) -> Bool {
  return lhs.number > rhs.number
}

