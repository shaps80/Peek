//
//  UIViewController+Modal.swift
//  Peek
//
//  Created by Shaps Benkau on 21/02/2018.
//

import UIKit

extension UIViewController {
    
    func presentModal(_ viewControllerToPresent: UIViewController, from sourceView: UIView?, animated: Bool, completion: (() -> Void)?) {
//        guard UIDevice.current.userInterfaceIdiom == .phone || viewControllerToPresent.modalTransitionStyle == .crossDissolve else {
//            let bounds = sourceView?.bounds ?? .zero
//            let rect = CGRect(x: bounds.midX - 1, y: bounds.midY - 1, width: 2, height: 2)
//
//            viewControllerToPresent.modalPresentationStyle = .popover
//            viewControllerToPresent.popoverPresentationController?.sourceRect = rect
//            viewControllerToPresent.popoverPresentationController?.sourceView = sourceView
//            viewControllerToPresent.popoverPresentationController?.backgroundColor = .clear
//            viewControllerToPresent.popoverPresentationController?.permittedArrowDirections = .any
//            viewControllerToPresent.popoverPresentationController?.backgroundColor = .inspectorBackground
//            viewControllerToPresent.preferredContentSize = CGSize(width: 375, height: 667)
//            present(viewControllerToPresent, animated: true, completion: nil)
//
//            return
//        }
        
        let controller = InspectorsPresentationController(presentedViewController: viewControllerToPresent, presenting: presentingViewController)
        
        withExtendedLifetime(controller) { _ in
            viewControllerToPresent.transitioningDelegate = controller
            self.present(viewControllerToPresent, animated: animated, completion: completion)
        }
    }
    
}
