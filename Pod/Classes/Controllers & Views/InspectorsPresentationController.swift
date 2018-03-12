//
//  InspectorsPresentationController.swift
//  Peek
//
//  Created by Shaps Benkau on 21/02/2018.
//

import UIKit

internal final class InspectorsPresentationController: UIPresentationController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    override var presentationStyle: UIModalPresentationStyle {
        return .overFullScreen
    }
    
    //! The corner radius applied to the view containing the presented view
    //! controller.
    private let cornerRadius: CGFloat = 20
    private let shadow: NSShadow = NSShadow.modal
    private let scale: CGFloat = 0.95
    
    private var dimmedColor: UIColor = .clear
    private var dimmedAlpha: CGFloat = 0.7
    private var dimmingView: UIView?
    private var presentationWrappingView: UIView?
    
    //| ----------------------------------------------------------------------------
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        // The presented view controller must have a modalPresentationStyle
        // of UIModalPresentationCustom for a custom presentation controller
        // to be used.
        presentedViewController.modalPresentationStyle = .custom
    }
    
    //| ----------------------------------------------------------------------------
    override var presentedView: UIView? {
        // Return the wrapping view created in -presentationTransitionWillBegin.
        return self.presentationWrappingView
    }
    
    //| ----------------------------------------------------------------------------
    //  This is one of the first methods invoked on the presentation controller
    //  at the start of a presentation.  By the time this method is called,
    //  the containerView has been created and the view hierarchy set up for the
    //  presentation.  However, the -presentedView has not yet been retrieved.
    //
    override func presentationTransitionWillBegin() {
        // The default implementation of -presentedView returns
        // self.presentedViewController.view.
        let presentedViewControllerView = super.presentedView!
        
        // Wrap the presented view controller's view in an intermediate hierarchy
        // that applies a shadow and rounded corners to the top-left and top-right
        // edges.  The final effect is built using three intermediate views.
        //
        // presentationWrapperView              <- shadow
        //   |- presentationRoundedCornerView   <- rounded corners (masksToBounds)
        //        |- presentedViewControllerWrapperView
        //             |- presentedViewControllerView (presentedViewController.view)
        //
        // SEE ALSO: The note in AAPLCustomPresentationSecondViewController.m.
        do {
            let presentationWrapperView = UIView(frame: frameOfPresentedViewInContainerView)
            presentationWrapperView.shadow = shadow
            presentationWrappingView = presentationWrapperView
            
            // presentationRoundedCornerView is CORNER_RADIUS points taller than the
            // height of the presented view controller's view.  This is because
            // the cornerRadius is applied to all corners of the view.  Since the
            // effect calls for only the top two corners to be rounded we size
            // the view such that the bottom CORNER_RADIUS points lie below
            // the bottom edge of the screen.
            
            let cornerViewRect = UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsets(top: 0, left: 0, bottom: -cornerRadius, right: 0))
            
            let presentationRoundedCornerView = UIView(frame: cornerViewRect)
            presentationRoundedCornerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            presentationRoundedCornerView.layer.cornerRadius = cornerRadius
            presentationRoundedCornerView.layer.masksToBounds = true
            
            // To undo the extra height added to presentationRoundedCornerView,
            // presentedViewControllerWrapperView is inset by CORNER_RADIUS points.
            // This also matches the size of presentedViewControllerWrapperView's
            // bounds to the size of -frameOfPresentedViewInContainerView.
            let wrapperRect = UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsets(top: 0, left: 0, bottom: cornerRadius, right: 0))
            
            let presentedViewControllerWrapperView = UIView(frame: wrapperRect)
            presentedViewControllerWrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Add presentedViewControllerView -> presentedViewControllerWrapperView.
            presentedViewControllerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds
            presentedViewControllerWrapperView.addSubview(presentedViewControllerView)
            
            // Add presentedViewControllerWrapperView -> presentationRoundedCornerView.
            presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
            
            // Add presentationRoundedCornerView -> presentationWrapperView.
            presentationWrapperView.addSubview(presentationRoundedCornerView)
        }
        
        // Add a dimming view behind presentationWrapperView.  self.presentedView
        // is added later (by the animator) so any views added here will be
        // appear behind the -presentedView.
        do {
            let dimmingView = UIView(frame: containerView?.bounds ?? .zero)
            dimmingView.backgroundColor = dimmedColor
            dimmingView.isOpaque = false
            dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
            dimmingView.addGestureRecognizer(gesture)
            
            self.dimmingView = dimmingView
            containerView?.addSubview(dimmingView)
            
            // Get the transition coordinator for the presentation so we can
            // fade in the dimmingView alongside the presentation animation.
            let transitionCoordinator = self.presentingViewController.transitionCoordinator
            
            dimmingView.alpha = 0.0
            transitionCoordinator?.animate(alongsideTransition: { _ in
                self.dimmingView?.alpha = self.dimmedAlpha
            }, completion: nil)
        }
    }
    
    @objc private func dismiss() {
        if let nav = presentedViewController as? UINavigationController {
            let inspectors = nav.viewControllers.flatMap { $0 as? PeekInspectorViewController }
            if (inspectors.filter { $0.tableView.isEditing }).count > 0 { return }
        }
        
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    //| ----------------------------------------------------------------------------
    override func presentationTransitionDidEnd(_ completed: Bool) {
        // The value of the 'completed' argument is the same value passed to the
        // -completeTransition: method by the animator.  It may
        // be NO in the case of a cancelled interactive transition.
        if !completed {
            // The system removes the presented view controller's view from its
            // superview and disposes of the containerView.  This implicitly
            // removes the views created in -presentationTransitionWillBegin: from
            // the view hierarchy.  However, we still need to relinquish our strong
            // references to those view.
            presentationWrappingView = nil
            dimmingView = nil
        }
    }
    
    //| ----------------------------------------------------------------------------
    override func dismissalTransitionWillBegin() {
        // Get the transition coordinator for the dismissal so we can
        // fade out the dimmingView alongside the dismissal animation.
        let transitionCoordinator = presentingViewController.transitionCoordinator
        
        transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView?.alpha = 0.0
        }, completion: nil)
    }
    
    //| ----------------------------------------------------------------------------
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        // The value of the 'completed' argument is the same value passed to the
        // -completeTransition: method by the animator.  It may
        // be NO in the case of a cancelled interactive transition.
        if completed {
            // The system removes the presented view controller's view from its
            // superview and disposes of the containerView.  This implicitly
            // removes the views created in -presentationTransitionWillBegin: from
            // the view hierarchy.  However, we still need to relinquish our strong
            // references to those view.
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    // MARK: -
    // MARK: Layout
    
    //    override func adaptivePresentationStyle(for traitCollection: UITraitCollection) -> UIModalPresentationStyle {
    //        if traitCollection.userInterfaceIdiom == .phone && traitCollection.horizontalSizeClass == .regular {
    //            return .formSheet
    //        }
    //
    //        return traitCollection.horizontalSizeClass == .compact || traitCollection.userInterfaceIdiom == .phone ? .overFullScreen : .custom
    //    }
    
    //| ----------------------------------------------------------------------------
    //  This method is invoked whenever the presentedViewController's
    //  preferredContentSize property changes.  It is also invoked just before the
    //  presentation transition begins (prior to -presentationTransitionWillBegin).
    //
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if container === presentedViewController {
            self.containerView?.setNeedsLayout()
        }
    }
    
    //| ----------------------------------------------------------------------------
    //  When the presentation controller receives a
    //  -viewWillTransitionToSize:withTransitionCoordinator: message it calls this
    //  method to retrieve the new size for the presentedViewController's view.
    //  The presentation controller then sends a
    //  -viewWillTransitionToSize:withTransitionCoordinator: message to the
    //  presentedViewController with this size as the first argument.
    //
    //  Note that it is up to the presentation controller to adjust the frame
    //  of the presented view controller's view to match this promised size.
    //  We do this in -containerViewWillLayoutSubviews.
    //
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        guard container === presentedViewController else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
        
        let width = min(UIApplication.shared.statusBarOrientation == .portrait ? parentSize.width : parentSize.height, 375)
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height + 20
        let height = parentSize.height - statusBarHeight
        return CGSize(width: width, height: height)
    }
    
    //| ----------------------------------------------------------------------------
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerViewBounds = containerView?.bounds ?? .zero
        let presentedViewContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerViewBounds.size)
        
        // The presented view extends presentedViewContentSize.height points from
        // the bottom edge of the screen.
        var presentedViewControllerFrame = containerViewBounds
        let statusBarHeight: CGFloat = 20
        
        presentedViewControllerFrame.size = presentedViewContentSize
        presentedViewControllerFrame.origin.x = (containerViewBounds.width - presentedViewControllerFrame.width) / 2
        presentedViewControllerFrame.size.height -= statusBarHeight
        presentedViewControllerFrame.origin.y = containerViewBounds.maxY - presentedViewContentSize.height + statusBarHeight
        
        return presentedViewControllerFrame
    }
    
    //| ----------------------------------------------------------------------------
    //  This method is similar to the -viewWillLayoutSubviews method in
    //  UIViewController.  It allows the presentation controller to alter the
    //  layout of any custom views it manages.
    //
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        self.dimmingView?.frame = containerView?.bounds ?? .zero
        self.presentationWrappingView?.frame = frameOfPresentedViewInContainerView
    }
    
    // MARK: -
    // MARK: UIViewControllerAnimatedTransitioning
    
    //| ----------------------------------------------------------------------------
    @objc func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionContext?.isAnimated ?? false ? 0.5 : 0
    }
    
    //| ----------------------------------------------------------------------------
    //  The presentation animation is tightly integrated with the overall
    //  presentation so it makes the most sense to implement
    //  <UIViewControllerAnimatedTransitioning> in the presentation controller
    //  rather than in a separate object.
    //
    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
        
        // If NO is returned from -shouldRemovePresentersView, the view associated
        // with UITransitionContextFromViewKey is nil during presentation.  This
        // intended to be a hint that your animator should NOT be manipulating the
        // presenting view controller's view.  For a dismissal, the -presentedView
        // is returned.
        //
        // Why not allow the animator to manipulate the presenting view controller's
        // view at all times?  First of all, if the presenting view controller's
        // view is going to stay visible after the animation finishes during the
        // whole presentation life cycle there is no need to animate it at all — it
        // just stays where it is.  Second, if the ownership for that view
        // controller is transferred to the presentation controller, the
        // presentation controller will most likely not know how to layout that
        // view controller's view when needed, for example when the orientation
        // changes, but the original owner of the presenting view controller does not.
        let fromView = transitionContext.view(forKey: .from)
        
        let isPresenting = (fromViewController === presentingViewController)
        
        // We are responsible for adding the incoming view to the containerView
        // for the presentation (will have no effect on dismissal because the
        // presenting view controller's view was not removed).
        if toView != nil {
            containerView.addSubview(toView!)
        }
       
        if isPresenting {
            if presentedViewController.modalTransitionStyle == .crossDissolve {
                toView?.alpha = 0
            } else {
                toView?.transform = CGAffineTransform(translationX: 0, y: toView?.bounds.maxY ?? containerView.bounds.maxY)
            }
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .beginFromCurrentState, animations: {
            if isPresenting {
                toView?.transform = .identity
                toView?.alpha = 1
            } else {
                if self.presentedViewController.modalTransitionStyle == .crossDissolve {
                    fromView?.alpha = 0
                } else {
                    fromView?.transform = CGAffineTransform(translationX: 0, y: fromView?.bounds.maxY ?? containerView.bounds.maxY)
                }
            }
            
        }, completion: { _ in
            // When we complete, tell the transition context
            // passing along the BOOL that indicates whether the transition
            // finished or not.
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        })
    }
    
    // MARK: -
    // MARK: UIViewControllerTransitioningDelegate
    
    //| ----------------------------------------------------------------------------
    //  If the modalPresentationStyle of the presented view controller is
    //  UIModalPresentationCustom, the system calls this method on the presented
    //  view controller's transitioningDelegate to retrieve the presentation
    //  controller that will manage the presentation.  If your implementation
    //  returns nil, an instance of UIPresentationController is used.
    //
    @objc func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        assert(presentedViewController === presented, "You didn't initialize \(self) with the correct presentedViewController.  Expected \(presented), got \(presentedViewController).")
        return self
    }
    
    //| ----------------------------------------------------------------------------
    //  The system calls this method on the presented view controller's
    //  transitioningDelegate to retrieve the animator object used for animating
    //  the presentation of the incoming view controller.  Your implementation is
    //  expected to return an object that conforms to the
    //  UIViewControllerAnimatedTransitioning protocol, or nil if the default
    //  presentation animation should be used.
    //
    @objc func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    //| ----------------------------------------------------------------------------
    //  The system calls this method on the presented view controller's
    //  transitioningDelegate to retrieve the animator object used for animating
    //  the dismissal of the presented view controller.  Your implementation is
    //  expected to return an object that conforms to the
    //  UIViewControllerAnimatedTransitioning protocol, or nil if the default
    //  dismissal animation should be used.
    //
    @objc func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}

extension NSShadow {
    public static var modal: NSShadow {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: -2)
        shadow.shadowBlurRadius = 10
        shadow.shadowColor = UIColor(white: 0, alpha: 0.75)
        return shadow
    }
}

extension UIView {
    
    public var shadow: NSShadow? {
        get {
            let shadow = NSShadow()
            shadow.shadowOffset = layer.shadowOffset
            shadow.shadowColor = UIColor(cgColor: layer.shadowColor ?? UIColor.black.cgColor)
                .withAlphaComponent(CGFloat(layer.shadowOpacity))
            shadow.shadowBlurRadius = layer.shadowRadius
            return shadow
        } set {
            guard let shadow = newValue else {
                layer.shadowPath = nil
                layer.shadowColor = nil
                layer.shadowOffset = .zero
                layer.shadowRadius = 0
                layer.shadowOpacity =  0
                return
            }
            
            layer.shadowRadius = shadow.shadowBlurRadius
            layer.shadowColor = (shadow.shadowColor as? UIColor)?.cgColor
            layer.shadowOffset = .zero
            let color = shadow.shadowColor as? UIColor ?? .black
            layer.shadowOpacity = Color(systemColor: color)?.rgba.alpha ?? 0.5
        }
    }
    
}
