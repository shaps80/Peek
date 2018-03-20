//
//  ReportActivity.swift
//  Peek
//
//  Created by Shaps Benkau on 06/03/2018.
//

import UIKit
import MobileCoreServices

internal final class ReportActivity: NSObject, UIActivityItemSource {
    
    private let report: Report
    
    internal init(report: Report) {
        self.report = report
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivityType?, suggestedSize size: CGSize) -> UIImage? {
        return report.snapshot?.resized(to: size)
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "Peek Report"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {
        guard let type = activityType else { return report.plainText }
        
        switch type {
        case .mail:
            return report.html
        default:
            return report.plainText
        }
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return "Peek Report: \(formatter.string(from: Date()))"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivityType?) -> String {
        guard let type = activityType else { return kUTTypePlainText as String }
        
        switch type {
        case .mail:
            return kUTTypeHTML as String
        default:
            return kUTTypePlainText as String
        }
    }
    
}
