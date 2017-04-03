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

class Model {
  
  static let totalWeeks = 26
  
  fileprivate(set) var weeks: [Week]!
  
  fileprivate var path: String = {
    let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    return docs.appendingPathComponent("Track.model")
  }()
  
  init() {
    prepare()
  }
  
  fileprivate func prepare() {
    weeks = [Week]()
    
    if let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
      let JSON = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
        
        for attributes in JSON {
          weeks.append(Week(fromJSON: attributes))
        }
        
        if weeks.count == Model.totalWeeks {
          return
        }
    }
    
    // otherwise lets initialize the initial data
    for i in 1...Model.totalWeeks {
      weeks.append(Week(number: i))
    }
    
  }
  
  fileprivate func toJSON() -> [[String: AnyObject]] {
    var JSON = [[String: AnyObject]]()
    
    for week in weeks {
      JSON.append(week.toJSON())
    }
    
    return JSON
  }
  
  func save() {
    let data = try! JSONSerialization.data(withJSONObject: toJSON(), options: [])
    try? data.write(to: URL(fileURLWithPath: path), options: [.atomic])
  }
  
  func updateWeek(_ week: Week) {
    if let index = weeks.index(of: week) {
      weeks.remove(at: index)
      weeks.insert(week, at: index)
      
      save()
    } else {
      print("Couldn't find matching week!")
    }
  }
  
  func complete(_ week: Week) -> Bool {
    return week.complete() && ImageCache.sharedCache().imageExists(week)
  }
  
  func currentWeek() -> Week {
    for week in weeks {
      if !complete(week) {
        return week
      }
    }
    
    return weeks.first!
  }
  
}
