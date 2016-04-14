//
//  Model.swift
//  Track
//
//  Created by Shaps Mohsenin on 09/02/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation

class Model {
  
  static let totalWeeks = 26
  
  private(set) var weeks: [Week]!
  
  private var path: String = {
    let docs = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
    return docs.stringByAppendingPathComponent("Track.model")
  }()
  
  init() {
    prepare()
  }
  
  private func prepare() {
    weeks = [Week]()
    
    if let data = NSData(contentsOfFile: path),
      JSON = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as? [[String: AnyObject]] {
        
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
  
  private func toJSON() -> [[String: AnyObject]] {
    var JSON = [[String: AnyObject]]()
    
    for week in weeks {
      JSON.append(week.toJSON())
    }
    
    return JSON
  }
  
  func save() {
    let data = try! NSJSONSerialization.dataWithJSONObject(toJSON(), options: [])
    data.writeToFile(path, atomically: true)
  }
  
  func updateWeek(week: Week) {
    if let index = weeks.indexOf(week) {
      weeks.removeAtIndex(index)
      weeks.insert(week, atIndex: index)
      
      save()
    } else {
      print("Couldn't find matching week!")
    }
  }
  
  func complete(week: Week) -> Bool {
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
