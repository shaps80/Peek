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
    
    enum CodingKeys: String, CodingKey {
        case sections = "categories"
        case deviceInfo = "device"
        case metadata = "metadata"
        case title = "title"
    }
    
    internal let sections: [Section]
    internal let title: String
    internal let metadata: [String: String]
    internal let snapshot: UIImage?
    private let deviceInfo: [String: String]
    
    internal init(title: String, sections: [Section], metadata: [String: String], snapshot: UIImage?) {
        self.metadata = metadata
        self.sections = sections
        self.title = title
        self.snapshot = snapshot
        
        deviceInfo = [
            "App Name": Bundle.main.appName,
            "Version": Bundle.main.version,
            "Build": Bundle.main.build,
            "Bundle Identifier": Bundle.main.bundleIdentifier ?? "Unknown",
            "Hostname": ProcessInfo().hostName,
            "iOS Version": UIDevice.current.systemVersion,
            "Device Type": UIDevice.current.model,
            "Device Name": UIDevice.current.name,
            "Device Model": UIDevice.current.model,
        ]
        
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
    
    internal var includeJSONReport: Bool {
        get { return UserDefaults.standard.bool(forKey: "includeJSON") }
        set { UserDefaults.standard.set(newValue, forKey: "includeJSON") }
    }
    
    internal var html: String {
        let html = """
        <html><head><style>
            body { font-family: sans-serif; font-size: 14; }
            table { width: 100%; }
            tr { vertical-align: top; }
            tr td:first-child { width: 50%; white-space: wrap; }
            tr td:last-child { width: 50%; text-align: right; white-space: wrap; }
            td { padding: 5pt; background-color: #F4F4F4; }
            tr.header td { text-align: left; background-color: #ffffff; padding-top: 1.2em; }
        </style></head>
        <body>
            <table>_REPORT_</table>
        </body></html>
        """
        var report = "<tr class=\"header\"><td colspan=\"2\">\(title)</td></tr>"
        
        for section in sections {
            report += """
            <tr class="header"><td colspan="2">\(section.title)</td></tr>
            """
            
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
        
        enum Section: String, CodingKey {
            case title = "title"
            case items = "issues"
        }
        
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
        
        let keyPath: String
        let displayTitle: String
        let displayValue: String
        let reportersNote: String
        
        internal func encode(to encoder: Encoder) throws {
            var container = try encoder.container(keyedBy: CodingKeys.self)
            try container.encode(keyPath, forKey: .keyPath)
            try container.encode(displayTitle, forKey: .displayTitle)
            try container.encode(displayValue, forKey: .displayValue)
            try container.encode(reportersNote, forKey: .reportersNote)
        }
        
    }
    
}
