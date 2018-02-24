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
        
        if let view = model as? UIView {
            view.preparePeek(context)
            view.layer.preparePeek(context)
            view.owningViewController()?.preparePeek(context)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 375, height: CGFloat.greatestFiniteMagnitude)
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .inspectorBackground
        tabBar.tintColor = .primaryTint
        
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = .lightGray
        }
        
        let inspector = InspectorViewController(peek: peek, model: model, context: context)
        let nav = UINavigationController(rootViewController: inspector)
        
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.backgroundColor = .inspectorBackground
        nav.navigationBar.tintColor = .primaryTint
        nav.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.clear,
        ]
        
        inspector.title = "Attributes"
        
        if #available(iOS 11.0, *) {
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationBar.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        }
        
        viewControllers = [nav]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.index(of: item) {
            guard let nav = viewControllers?[index] as? UINavigationController,
                let inspector = nav.viewControllers.first as? InspectorViewController else {
                    fatalError()
            }
            
            print(inspector)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return peek.supportedOrientations
    }
    
    // MARK: Unused
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
