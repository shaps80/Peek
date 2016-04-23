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