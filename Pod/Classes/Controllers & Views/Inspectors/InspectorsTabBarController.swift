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
import SwiftLayout

/// Defines a controller that represents an Inspector Set
class InspectorsTabBarController: UITabBarController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    fileprivate let model: Model
    unowned var peek: Peek
    fileprivate let context: Context
    fileprivate var currentInspectorSet = InspectorSet.secondary
    
    init(peek: Peek, model: Model) {
        self.model = model
        self.peek = peek
        self.context = PeekContext()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = UIColor.white
        
        if let view = model as? UIView {
            view.preparePeek(context)
            view.layer.preparePeek(context)
            view.owningViewController()?.preparePeek(context)
        }
        
        UIDevice.current.preparePeek(context)
        UIScreen.main.preparePeek(context)
        UIApplication.shared.preparePeek(context)
        
        tabBar.barStyle = .black
        tabBar.tintColor = .secondaryColor()
        
        prepareInspectors(.primary)
        
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 375, height: CGFloat.greatestFiniteMagnitude)
    }
    
    @objc fileprivate func toggleInspectors() {
        prepareInspectors(currentInspectorSet == .primary ? .secondary : .primary)
    }
    
    func prepareInspectors(_ inspectorSet: InspectorSet) {
        currentInspectorSet = inspectorSet
        
        let inspectors = inspectorSet.inspectors()
        var controllers = [UINavigationController]()
        
        for inspector in inspectors {
            let dataSource = ContextDataSource(context: context, inspector: inspector)
            let controller = InspectorViewController(peek: peek, model: modelForInspector(inspector), dataSource: dataSource)
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                controller.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.backIndicatorImage(), style: .plain, target: self, action: #selector(self.back(_:)))
                controller.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
            }
            
            controller.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.inspectorsToggleImage(inspectorSet), style: .plain, target: self, action: #selector(self.toggleInspectors))
            controller.navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
            
            let navController = UINavigationController(rootViewController: controller)
            
            navController.navigationBar.barStyle = .black
            navController.navigationBar.backIndicatorImage = Images.backIndicatorImage()
            navController.navigationBar.backIndicatorTransitionMaskImage = Images.backIndicatorImage()
            navController.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor(white: 1, alpha: 0.5),
                .font: UIFont(name: "Avenir-Book", size: 16)!
            ]
            
            controllers.append(navController)
        }
        
        viewControllers = controllers
        selectedIndex = UserDefaults.standard.integer(forKey: "lastSelectedTab.\(inspectorSet.rawValue)")
        
        title = tabBar.selectedItem?.title
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.index(of: item) {
            UserDefaults.standard.set(index, forKey: "lastSelectedTab.\(currentInspectorSet.rawValue)")
        }
        
        title = item.title
    }
    
    fileprivate func modelForInspector(_ inspector: Inspector) -> Model {
        switch inspector {
        case .device: return UIDevice.current
        case .application: return UIApplication.shared
        case .controller: return (model as! UIView).owningViewController()!
        case .screen: return UIScreen.main
        default: return model
        }
    }
    
    @objc fileprivate func back(_ sender: AnyObject?) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return peek.supportedOrientations
    }
    
}
