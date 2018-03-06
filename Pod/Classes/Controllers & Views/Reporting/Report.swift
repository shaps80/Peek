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
    internal let title: String
    
    internal init(title: String, sections: [Section]) {
        self.sections = sections
        self.title = title
        
        UserDefaults.standard.register(defaults: [
            "includeScreenshot": true,
            "includeJSON": true,
            "includeMetadata": true
        ])
    }
    
    internal var includeScreenshot: Bool {
        get { return UserDefaults.standard.bool(forKey: "includeScreenshot") }
        set { UserDefaults.standard.set(newValue, forKey: "includeScreenshot") }
    }
    
    internal var includeJSON: Bool {
        get { return UserDefaults.standard.bool(forKey: "includeJSON") }
        set { UserDefaults.standard.set(newValue, forKey: "includeJSON") }
    }
    
    internal var includeMetadata: Bool {
        get { return UserDefaults.standard.bool(forKey: "includeMetadata") }
        set { UserDefaults.standard.set(newValue, forKey: "includeMetadata") }
    }
    
    internal var html: String {
        let html = """
        <html><head><style>
            table { width: 100%; font-size: 14; }
            tr { vertical-align: top; }
            tr td:first-child { width: 50%; white-space: wrap; font-weight: bold; }
            tr td:last-child { width: 50%; text-align: right; white-space: wrap; }
            td { padding: 5pt; background-color: #F4F4F4; }
        </style></head>
        <body>
            <p><strong>_TITLE_</strong></p>
            <table>_REPORT_</table>
        </body></html>
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
        
        return html
            .replacingOccurrences(of: "_TITLE_", with: title)
            .replacingOccurrences(of: "_REPORT_", with: report)
    }
    
    internal var markdown: String {
        var text = "**\(title)**\n```\n"
        
        for section in sections {
            text += """
            | \(section.title) | Suggested Value |
            | ------------- | -------------:|
            
            """
            
            for item in section.items {
                text += "| \(item.displayTitle) | \(item.reportersNote) |\n"
            }
            
            text += "\n"
        }
        
        return text + "```"
    }
    
    internal var plainText: String {
        var text = "\(title)\n\n"
        
        for section in sections {
            text += """
            \(section.title)
            ---
            
            """
            
            for item in section.items {
                text += "\(item.displayTitle): \(item.reportersNote)\n"
            }
            
            text += "\n"
        }
        
        return text
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
