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
import GraphicsRenderer

final class PeekViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    private var observer: Any?
    unowned var peek: Peek
    
    init(peek: Peek) {
        self.peek = peek
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var models = [UIView]()
    
    internal lazy var peekView: PeekView = {
        let view = PeekView()
        view.delegate = self
        return view
    }()
    
    lazy var attributesButton: PeekButton = {
        let button = PeekButton(frame: .zero)
        button.addTarget(self, action: #selector(showInspectors), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(peekView, constraints: [
            equal(\.leadingAnchor), equal(\.trailingAnchor),
            equal(\.topAnchor), equal(\.bottomAnchor)
        ])
        
        parseView(peek.peekingWindow)
        models.reverse()
        
        view.backgroundColor = .clear
        
        view.addSubview(attributesButton, constraints: [
            equal(\.centerXAnchor)
        ])
        
        bottomLayoutGuide.bottomAnchor.constraint(equalTo: attributesButton.bottomAnchor, constant: 30).isActive = true
        setAttributesButton(hidden: true, animated: false)
        
        peekView.refresh()
    }
    
    private func setAttributesButton(hidden: Bool, animated: Bool) {
        let transform = CGAffineTransform(translationX: 0, y: 120)
        
        guard animated else {
            attributesButton.transform = hidden ? transform : .identity
            return
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .beginFromCurrentState, animations: {
            self.attributesButton.transform = hidden ? transform : .identity
        }, completion: nil)
    }
    
    private var feedbackGenerator: Any?
    
    @available(iOS 10.0, *)
    private func haptic() -> UIImpactFeedbackGenerator? {
        return feedbackGenerator as? UIImpactFeedbackGenerator
    }
    
//    func updateSelectedModels(_ gesture: UIGestureRecognizer) {
//        let location = gesture.location(in: gesture.view)
//
//        for next in models.reversed() {
//            let modelRect = next.frameInPeek(view)
//
//            if modelRect.contains(location) {
//                let models = overlayView.selectedModels
//
//                if !models.contains(next) {
//                    if isDragging {
//                        if let previous = models.first, overlayView.selectedModels.count > 1 {
//                            overlayView.selectedModels = [previous, next]
//                        } else {
//                            overlayView.selectedModels = [next]
//                        }
//                    } else {
//                        if let previous = models.last {
//                            overlayView.selectedModels = [previous, next]
//                        } else {
//                            overlayView.selectedModels = [next]
//                        }
//                    }
//
//                    if #available(iOS 10.0, *) {
//                        if feedbackGenerator == nil {
//                            UIImpactFeedbackGenerator().impactOccurred()
//                        } else {
//                            haptic()?.impactOccurred()
//                        }
//                    }
//                } else {
//                    guard gesture == tapGesture else { return }
//                    overlayView.selectedModels.reverse()
//                }
//
//                break
//            }
//        }
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition(in: view, animation: { _ in
            self.peekView.refresh()
        }, completion: nil)
    }
    
    private func parseView(_ view: UIView) {
        for view in view.subviews {
            if !view.shouldIgnore(options: peek.options) {
                models.append(view)
            }
            
            if view.subviews.count > 0 {
                parseView(view)
            }
        }
    }
    
    fileprivate func updateBackgroundColor(alpha: CGFloat) {
        view.backgroundColor = UIColor.overlay?.withAlphaComponent(alpha)
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = 0.1
        view.layer.add(animation, forKey: "fade")
    }
    
    @objc private func showInspectors() {
        guard let index = peekView.indexesForSelectedItems.last, let model = models[index] as? UIView else { return }
        presentInspectorsForModel(model)
    }
    
    fileprivate func presentInspectorsForModel(_ model: Model) {
        let rect = peek.peekingWindow.bounds

        var defaults: [String: Bool] = [:]
        Group.all.forEach {
            defaults[$0.title] = $0.isExpandedByDefault
        }
        UserDefaults.standard.register(defaults: defaults)
        
        peek.screenshot = ImageRenderer(size: CGSize(width: rect.width, height: rect.height)).image { context in
            let rect = context.format.bounds
            self.peek.peekingWindow.drawHierarchy(in: rect, afterScreenUpdates: true)
            self.peek.window?.drawHierarchy(in: rect, afterScreenUpdates: true)
        }
        
        if let model = model as? UIView {
            let controller = InspectorsTabController(peek: peek, model: model)
            
            definesPresentationContext = true
            controller.view.frame = view.bounds
            
            presentModal(controller, from: model, animated: true, completion: nil)
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

extension PeekViewController: PeekViewDelegate {
    
    func viewModels(in peekView: PeekView) -> [UIView] {
        return models
    }
    
    func showInsectorFor(viewModel: UIView, in peekView: PeekView) {
        presentInspectorsForModel(viewModel)
    }
    
    func didSelect(viewModel: UIView, in peekView: PeekView) {
        
    }
    
    func didBeginDragging(in peekView: PeekView) {
        setAttributesButton(hidden: true, animated: true)
    }
    
    func didEndDragging(in peekView: PeekView) {
        let hidden = peekView.indexesForSelectedItems.count == 0
        setAttributesButton(hidden: hidden, animated: true)
    }
    
}
