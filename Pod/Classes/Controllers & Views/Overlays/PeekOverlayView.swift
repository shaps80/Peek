//
//  PeekView.swift
//  Peek
//
//  Created by Shaps Benkau on 11/03/2018.
//

import UIKit

internal protocol ViewModel: Peekable, Model {
    func frameInPeek(_ view: UIView) -> CGRect
}

extension UIView: ViewModel { }

internal protocol PeekOverlayViewDelegate: class {
    func viewModels(in overlayView: PeekOverlayView) -> [ViewModel]
    func didSelect(viewModel: ViewModel, in overlayView: PeekOverlayView)
    func showInsectorFor(viewModel: ViewModel, in overlayView: PeekOverlayView)
    func didBegin(in overlayView: PeekOverlayView)
    func didEnd(in overlayView: PeekOverlayView)
}

internal class PeekOverlayView: UIView {
    
    internal weak var delegate: PeekOverlayViewDelegate?
    internal var allowsMultipleSelection: Bool = false
    
    internal private(set) var viewModels: [ViewModel] = []
    internal private(set) var indexesForSelectedItems: [Int] = []
    
    internal private(set) var isDragging: Bool = false
    private var feedbackGenerator: Any?
    private var observer: Any?
    
    @available(iOS 10.0, *)
    private func haptic() -> UIImpactFeedbackGenerator? {
        return feedbackGenerator as? UIImpactFeedbackGenerator
    }
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
    }()
    
    private lazy var doubleTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        gesture.numberOfTapsRequired = 2
        return gesture
    }()
    
    internal private(set) lazy var primarySelectionView: PeekSelectionView = {
        let view = PeekSelectionView(borderColor: .primaryTint, borderWidth: 1.5)
        addSubview(view)
        return view
    }()
    
    internal private(set) lazy var secondarySelectionView: PeekSelectionView = {
        let view = PeekSelectionView(borderColor: .white, borderWidth: 1.5)
        addSubview(view)
        return view
    }()
    
    internal init() {
        super.init(frame: .zero)
        
        if #available(iOS 11.0, *) {
            accessibilityIgnoresInvertColors = true
        }
        
        addGestureRecognizer(panGesture)
        addGestureRecognizer(tapGesture)
        addGestureRecognizer(doubleTapGesture)
        tapGesture.require(toFail: doubleTapGesture)
        
        updateBackgroundColor(alpha: 0.5)
        
        observer = NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: .main) { [weak self] _ in
            // we have to add a delay to allow the app to finish updating its layout.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.refresh()
            }
        }
    }
    
    internal func refresh() {
        viewModels = delegate?.viewModels(in: self) ?? []
        updateHighlights(animated: false)
        
        primarySelectionView.setNeedsDisplay()
        secondarySelectionView.setNeedsDisplay()
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            if #available(iOS 10.0, *) {
                feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                haptic()?.prepare()
            }
            
            updateBackgroundColor(alpha: 0.3)
            isDragging = true
            delegate?.didBegin(in: self)
        case .changed:
            hitTest(at: gesture.location(in: gesture.view))
        default:
            isDragging = false
            delegate?.didEnd(in: self)
            updateBackgroundColor(alpha: 0.5)
            feedbackGenerator = nil
        }
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if gesture === doubleTapGesture {
                guard let index = indexesForSelectedItems.last else { return }
                delegate?.showInsectorFor(viewModel: viewModels[index], in: self)
            } else {
                hitTest(at: gesture.location(in: gesture.view))
                delegate?.didEnd(in: self)
            }
        }
    }
    
    private func hitTest(at point: CGPoint) {
        for (index, model) in zip(viewModels.indices, viewModels) {
            let frame = model.frameInPeek(self)
            
            if frame.contains(point) {
                if !indexesForSelectedItems.contains(index) {
                    selectViewModel(at: index, animated: true)
                    delegate?.didSelect(viewModel: model, in: self)
                } else {
                    if !isDragging {
                        indexesForSelectedItems.reverse()
                        updateHighlights(animated: true)
                    }
                }
                
                break
            }
        }
    }
    
    private func selectViewModel(at index: Int, animated: Bool) {
        if !indexesForSelectedItems.isEmpty {
            if isDragging {
                indexesForSelectedItems.removeLast()
            } else {
                if indexesForSelectedItems.count > 1 {
                    indexesForSelectedItems.removeFirst()
                }
            }
        }
        
        if !allowsMultipleSelection {
            indexesForSelectedItems.removeAll()
        }
        
        indexesForSelectedItems.append(index)
        updateHighlights(animated: animated)

        if #available(iOS 10.0, *) {
            if feedbackGenerator == nil {
                UIImpactFeedbackGenerator().impactOccurred()
            } else {
                haptic()?.impactOccurred()
            }
        }
    }
    
    private func rectForPrimaryView() -> CGRect {
        guard let primary = indexesForSelectedItems.last else { return .zero }
        return viewModels[primary].frameInPeek(self)
    }
    
    private func rectForSecondaryView() -> CGRect {
        guard indexesForSelectedItems.count > 1,
            let secondary = indexesForSelectedItems.first else { return .zero }
        return viewModels[secondary].frameInPeek(self)
    }
    
    internal func updateHighlights(animated: Bool) {
        let primaryFrame = rectForPrimaryView()
        var secondaryFrame = rectForSecondaryView()
        
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.1, options: .beginFromCurrentState, animations: {
                self.primarySelectionView.frame = primaryFrame
                self.secondarySelectionView.frame = secondaryFrame
            }, completion: nil)
        } else {
            primarySelectionView.frame = primaryFrame
            secondarySelectionView.frame = secondaryFrame
        }
    }
    
    private func updateBackgroundColor(alpha: CGFloat) {
        backgroundColor = UIColor(white: 0, alpha: alpha)
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = 0.1
        layer.add(animation, forKey: "fade")
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
