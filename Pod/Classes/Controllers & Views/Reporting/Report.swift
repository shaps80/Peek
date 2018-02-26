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
internal struct Report: Encodable {
    
    internal let sections: [Section]
    
    internal init(sections: [Section]) {
        self.sections = sections
        UserDefaults.standard.register(defaults: ["includeScreenshot": true, "includeJSON": true])
    }
    
    internal var includeScreenshot: Bool {
        get { return UserDefaults.standard.bool(forKey: "includeScreenshot") }
        set { UserDefaults.standard.set(newValue, forKey: "includeScreenshot") }
    }
    
    internal var includeJSON: Bool {
        get { return UserDefaults.standard.bool(forKey: "includeJSON") }
        set { UserDefaults.standard.set(newValue, forKey: "includeJSON") }
    }
    
    internal var html: String {
        let html = """
        <html><head><style>
            table { width: 100%; font-size: 14; }
            tr { vertical-align: top; }
            tr td:first-child { width: 1%; white-space: nowrap; font-weight: bold; }
            tr td:last-child { text-align: right; }
            td { padding: 5pt; background-color: #F4F4F4; }
        </style></head>
        <body><table>_REPORT_</table></body></html>
        """
        var report = ""
        
        for section in sections {
            for item in section.items {
                report += """
                <tr>
                <td>\(item.displayTitle)</td>
                <td>\(item.reportersNote)</td>
                </tr>
                """
            }
        }
        
        return html.replacingOccurrences(of: "_REPORT_", with: report)
    }
    
}

extension Report {
    
    internal struct Section: Encodable {
        
        let title: String
        let items: [Item]
        
        init(title: String, items: [Item]) {
            self.title = title
            self.items = items
        }
        
    }
    
    internal struct Item: Encodable {
        
        enum CodingKeys: String, CodingKey {
            case keyPath
            case displayTitle
            case displayValue
            case reportersNote
        }
        
        private(set) var model: Model? = nil
        
        let keyPath: String
        let displayTitle: String
        let displayValue: String
        let reportersNote: String
        
        internal func encode(to encoder: Encoder) throws {
            var container = try encoder.container(keyedBy: CodingKeys.self)
            try container.encode(keyPath, forKey: .keyPath)
            try container.encode(displayTitle, forKey: .displayTitle)
            try container.encode(displayValue, forKey: .displayValue)
            try container.encode("Suggested Value: \(reportersNote)", forKey: .reportersNote)
        }
        
    }
    
}
