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

import UIKit
import InkKit

/// Defines an inspector's cell used to represent a Peek property
final class InspectorCell: UITableViewCell {
    
    override var accessoryView: UIView? {
        didSet { setNeedsUpdateConstraints() }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = accessoryView?.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        accessoryView?.backgroundColor = color
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = accessoryView?.backgroundColor
        super.setSelected(selected, animated: animated)
        accessoryView?.backgroundColor = color
    }
    
//    fileprivate func metaData() -> MetaData {
//        guard let model = model else {
//            fatalError("Model should never be nil!")
//        }
//
//        var metaData = MetaData()
//
//        let object = MetaDataItem(key: "Object", value: "\(model.ObjClassName())")
//        let title = MetaDataItem(key: "Display Name", value: property?.displayName)
//        let keyPath = MetaDataItem(key: "Key Path", value: property?.keyPath)
//        let value = MetaDataItem(key: "Value", value: stringValue())
//
//        metaData.property.items = [ object, title, keyPath, value ]
//
//        if let meta = peek?.options.metaData {
//            for (key, value) in meta {
//                let item = MetaDataItem(key: key, value: value)
//                metaData.metaData.items.append(item)
//            }
//        }
//
//        return metaData
//    }
    
//    fileprivate func stringValue() -> String? {
//        guard let model = self.model, let property = self.property else {
//            return nil
//        }
//        
//        if let value = detailTextLabel?.text {
//            return "\(value)"
//        }
//        
//        if let value = property.value(forModel: model) {
//            return "\(value)"
//        }
//        
//        return nil
//    }
    
}
