//
//  MetaData.swift
//  Peek
//
//  Created by Shaps Mohsenin on 01/05/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import Foundation

/**
 *  Provides a
 */
struct MetaData {
    
    var property: MetaDataSection = MetaDataSection(title: "Property")
    var metaData: MetaDataSection = MetaDataSection(title: "Meta Data")
    
    var message = ""
    var sections: [MetaDataSection] {
        return [property, metaData]
    }
    
    init() { }
    
    func JSONRepresentation() -> [[String: AnyObject]] {
        var JSON = [[String: AnyObject]]()
        
        for section in sections {
            for item in section.items {
                if let key = item.key, let value = item.value {
                    let field: [String: AnyObject] = [
                        "title": key as AnyObject,
                        "value": value as AnyObject,
                        "notes": "" as AnyObject,
                        "short": true as AnyObject,
                        // TODO: Would be great to include a field for priority?
//                        "color": SlackPriority.High.rawValue as AnyObject,
                        ]
                    
                    JSON.append(field)
                }
            }
        }
        
        return JSON
    }
    
    func HTMLRepresentation() -> String {
        let html = "" +
            "<head><style>\n" +
            "table { width: 100%; font-size: 14; }\n" +
            "tr { vertical-align: top; }\n" +
            "tr td:first-child { width: 1%; white-space: nowrap; font-weight: bold; }\n" +
            "tr td:last-child { text-align: right; }\n" +
            "td { padding: 5pt; background-color: #F4F4F4; }\n" +
            "</style></head>\n" +
            "<body><table>\n" +
            "FIELDS\n" +
        "</table></body>\n"
        
        var fields = ""
        
        for section in sections {
            for item in section.items {
                if let key = item.key, let value = item.value {
                    fields += "<tr><td>\(key)</td>\n<td>\(value)</td></tr>"
                }
            }
        }
        
        return html.replacingOccurrences(of: "FIELDS", with: fields)
    }
    
}

struct MetaDataSection: Equatable {
    
    let title: String
    var items = [MetaDataItem]()
    
    init(title: String) {
        self.title = title
    }
    
}

struct MetaDataItem: Equatable {
    
    let key: String?
    var value: String?
    
}


func ==(lhs: MetaDataSection, rhs: MetaDataSection) -> Bool {
    return lhs.title == rhs.title
}

func ==(lhs: MetaDataItem, rhs: MetaDataItem) -> Bool {
    return lhs.key == rhs.key && lhs.value == rhs.value
}
