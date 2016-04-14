//
//  PeekInspectorsTabBarController.swift
//  Pods
//
//  Created by Shaps Mohsenin on 05/02/2016.
//
//

import UIKit
import SwiftLayout

class InspectorsTabBarController: UITabBarController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
  
  private let model: Model
  unowned var peek: Peek
  private let context: Context
  private var currentInspectorSet = InspectorSet.Secondary
  
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
    
    if let view = model as? UIView {
      view.preparePeek(context)
      view.layer.preparePeek(context)
      view.owningViewController()?.preparePeek(context)
    }
    
    UIDevice.currentDevice().preparePeek(context)
    UIScreen.mainScreen().preparePeek(context)
    UIApplication.sharedApplication().preparePeek(context)
    
    tabBar.barStyle = .Black
    tabBar.selectionIndicatorImage = Images.tabItemIndicatorImage()
    
    prepareInspectors(.Primary)
    
    modalPresentationStyle = .Popover
    preferredContentSize = CGSizeMake(375, CGFloat.max)
  }
  
  @objc private func toggleInspectors() {
    prepareInspectors(currentInspectorSet == .Primary ? .Secondary : .Primary)
  }
  
  func prepareInspectors(inspectorSet: InspectorSet) {
    currentInspectorSet = inspectorSet
    
    let inspectors = inspectorSet.inspectors()
    var controllers = [UINavigationController]()
    
    for inspector in inspectors {
      let dataSource = ContextDataSource(context: context, inspector: inspector)
      let controller = InspectorViewController(peek: peek, model: modelForInspector(inspector), dataSource: dataSource)
      
      if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.backIndicatorImage(), style: .Plain, target: self, action: #selector(self.back(_:)))
        controller.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
      }
      
      controller.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.inspectorsToggleImage(inspectorSet), style: .Plain, target: self, action: #selector(self.toggleInspectors))
      controller.navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
      
      let navController = UINavigationController(rootViewController: controller)

      navController.navigationBar.barStyle = .Black
      navController.navigationBar.backIndicatorImage = Images.backIndicatorImage()
      navController.navigationBar.backIndicatorTransitionMaskImage = Images.backIndicatorImage()
      navController.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5), NSFontAttributeName: UIFont(name: "Avenir-Book", size: 16)! ]
      
      controllers.append(navController)
    }
    
    viewControllers = controllers
    selectedIndex = NSUserDefaults.standardUserDefaults().integerForKey("lastSelectedTab.\(inspectorSet.rawValue)")
    
    title = tabBar.selectedItem?.title
  }
  
  override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
    if let index = tabBar.items?.indexOf(item) {
      NSUserDefaults.standardUserDefaults().setInteger(index, forKey: "lastSelectedTab.\(currentInspectorSet.rawValue)")
    }
    
    title = item.title
  }
  
  private func modelForInspector(inspector: Inspector) -> Model {
    switch inspector {
    case .Device: return UIDevice.currentDevice()
    case .Application: return UIApplication.sharedApplication()
    case .Controller: return (model as! UIView).owningViewController()!
    case .Screen: return UIScreen.mainScreen()
    default: return model
    }
  }
  
  @objc private func back(sender: AnyObject?) {
    presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return peek.supportedOrientations
  }

}
