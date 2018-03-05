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
import UIKit.UIGestureRecognizerSubclass
import InkKit

final class PeekViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    unowned var peek: Peek
    
    init(peek: Peek) {
        self.peek = peek
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var models = [UIView]()
    fileprivate var isDragging: Bool = false {
        didSet {
            self.overlayView.isDragging = isDragging
        }
    }
    
    lazy var overlayView: OverlayView = {
        let view = OverlayView(peek: self.peek)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(PeekViewController.handlePan(_:)))
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(PeekViewController.handleTap(_:)))
    }()
    
    lazy var doubleTapGesture: PeekTapGestureRecognizer = {
        let gesture = PeekTapGestureRecognizer(target: self, action: #selector(PeekViewController.handleTap(_:)))
        gesture.numberOfTapsRequired = 2
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(overlayView)
        overlayView.pin(edges: .all, to: view)
        
        parseView(peek.peekingWindow)
        updateBackgroundColor(alpha: 0.5)
        
        overlayView.addGestureRecognizer(panGesture)
        overlayView.addGestureRecognizer(tapGesture)
        overlayView.addGestureRecognizer(doubleTapGesture)
        tapGesture.require(toFail: doubleTapGesture)
    }
    
    fileprivate func addModelForView(_ view: UIView) {
        if !view.shouldIgnore(options: peek.options) {
            models.append(view)
        }
    }
    
    func updateSelectedModels(_ gesture: UIGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        
        for model in models {
            let rect = model.frameInPeek(view)
            
            if rect.contains(location) {
                if let models = overlayView.selectedModels {
                    if !models.contains(model) {
                        if isDragging {
                            overlayView.selectedModels = [model]
                        } else {
                            if let previous = models.last {
                                overlayView.selectedModels = [previous, model]
                            } else {
                                overlayView.selectedModels = [model]
                            }
                        }
                    }
                }
                
                overlayView.selectedModels = [model]
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition(in: view, animation: { (_) -> Void in
            self.overlayView.reload()
        }, completion: nil)
    }
    
    fileprivate func parseView(_ view: UIView) {
        for view in view.subviews {
            addModelForView(view)
            
            if view.subviews.count > 0 {
                parseView(view)
            }
        }
    }
    
    fileprivate func updateBackgroundColor(alpha: CGFloat) {
        view.backgroundColor = UIColor.overlayColor().withAlphaComponent(alpha)
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = 0.1
        view.layer.add(animation, forKey: "fade")
    }
    
    fileprivate func presentInspectorsForModel(_ model: Model) {
        let rect = peek.peekingWindow.bounds

        var defaults: [String: Bool] = [:]
        Group.all.forEach {
            defaults[$0.title] = model.isExpandedByDefault(for: $0)
        }
        UserDefaults.standard.register(defaults: defaults)
        
        peek.screenshot = UIImage.draw(width: rect.width, height: rect.height, scale: 1 / UIScreen.main.scale, attributes: nil, drawing: { [unowned self] (_, rect, _) in
            self.peek.peekingWindow.drawHierarchy(in: rect, afterScreenUpdates: false)
            self.peek.window?.drawHierarchy(in: rect, afterScreenUpdates: false)
        })
        
        if let model = model as? UIView {
            let controller = InspectorsTabController(peek: peek, model: model)
            
            definesPresentationContext = true
            controller.view.frame = view.bounds
            
            presentModal(controller, from: overlayView.primaryView, animated: true, completion: nil)
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if gesture === doubleTapGesture {
                if let model = overlayView.selectedModels?.last {
                    presentInspectorsForModel(model)
                }
            } else {
                updateSelectedModels(gesture)
            }
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            updateBackgroundColor(alpha: 0.3)
            isDragging = true
            break
        case .changed:
            updateSelectedModels(gesture)
            break
        default:
            updateBackgroundColor(alpha: 0.5)
            isDragging = false
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return peek.supportedOrientations
    }
    
    override var prefersStatusBarHidden: Bool {
        return peek.previousStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return peek.previousStatusBarStyle
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        // iOS 10 now requires device motion handlers to be on a UIViewController
        peek.handleShake(motion)
    }
    
}
