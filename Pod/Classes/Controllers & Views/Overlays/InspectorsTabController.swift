//
//  InspectorsTabController.swift
//  Peek-Example
//
//  Created by Shaps Benkau on 21/02/2018.
//  Copyright © 2018 Snippex. All rights reserved.
//

import UIKit
import GraphicsRenderer

internal final class InspectorsTabController: UITabBarController {
    
    fileprivate let model: Model
    unowned var peek: Peek
    fileprivate let context: Context
    
    init(peek: Peek, model: Model) {
        self.model = model
        self.peek = peek
        self.context = PeekContext()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 375, height: CGFloat.greatestFiniteMagnitude)
        
        tabBar.barStyle = .black
        tabBar.barTintColor = .inspectorBackground
        tabBar.tintColor = .white
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = .lightGray
        }
        
        let inspector = InspectorViewController()
        let nav = UINavigationController(rootViewController: inspector)
        
        inspector.title = "Overview"
        inspector.tableView.backgroundColor = .inspectorBackground
        
        if #available(iOS 11.0, *) {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        nav.navigationBar.barStyle = .black
        nav.navigationBar.barTintColor = .inspectorBackground
        nav.navigationBar.tintColor = .white
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        viewControllers = [nav]
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return peek.supportedOrientations
    }
    
    // MARK: Unused
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
