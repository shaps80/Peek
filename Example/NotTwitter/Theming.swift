//
//  Theming.swift
//  NotTwitter
//
//  Created by Shaps Benkau on 10/03/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static var separator: UIColor {
        return UIColor(red: 189/255, green: 198/255, blue: 205/255, alpha: 1)
    }
    
    public static var background: UIColor {
        return .white
    }
    
    public static var selection: UIColor {
        return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    }
    
}

public struct Theme {
    
    public static func apply() {
        let bar = UINavigationBar.appearance()
        
        bar.barTintColor = .background
        bar.titleTextAttributes = [
            .foregroundColor: UIColor(red: 21/255, green: 23/255, blue: 26/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16, weight: .black)
        ]
        
        let table = UITableView.appearance()
        
        table.backgroundColor = .background
        table.separatorColor = .separator
    }
    
}
