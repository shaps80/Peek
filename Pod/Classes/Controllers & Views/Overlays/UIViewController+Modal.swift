//
//  UIViewController+Modal.swift
//  Peek
//
//  Created by Shaps Benkau on 21/02/2018.
//

import UIKit

extension UIViewController {
    
    func presentModal(_ viewControllerToPresent: UIViewController, from sourceView: UIView?, animated: Bool, completion: (() -> Void)?) {
        let controller = InspectorsPresentationController(presentedViewController: viewControllerToPresent, presenting: presentingViewController)
        
        withExtendedLifetime(controller) { _ in
            viewControllerToPresent.transitioningDelegate = controller
            self.present(viewControllerToPresent, animated: animated, completion: completion)
        }
    }
    
}
