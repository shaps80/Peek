//
//  PeekView.swift
//  Peek
//
//  Created by Shaps Benkau on 11/03/2018.
//

import UIKit

internal final class PeekSelectionView: UIView {
    
    private let borderWidth: CGFloat
    private let borderColor: UIColor
    private let dashed: Bool
 
    internal init(borderColor: UIColor?, borderWidth: CGFloat, dashed: Bool = false) {
        self.borderColor = borderColor ?? .white
        self.borderWidth = borderWidth
        self.dashed = dashed
        
        super.init(frame: .zero)
        
        backgroundColor = .clear
        layer.zPosition = 20
        
        guard !dashed else { return }
        
        layer.borderWidth = borderWidth
        layer.borderColor = self.borderColor.cgColor
        layer.cornerRadius = borderWidth * 2
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard dashed else { return }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard dashed else { return }
        
        let inset = borderWidth / 2
        let path = UIBezierPath(roundedRect: rect.insetBy(dx: inset, dy: inset), cornerRadius: borderWidth * 2)
        
        if dashed {
            path.setLineDash([4, 4], count: 2, phase: 0)
        }
        
        borderColor.setStroke()
        path.stroke()
    }
    
}

internal protocol PeekViewDelegate: class {
    func viewModels(in peekView: PeekView) -> [UIView]
    func didSelect(viewModel: UIView, in peekView: PeekView)
    func showInsectorFor(viewModel: UIView, in peekView: PeekView)
    func didBegin(in peekView: PeekView)
    func didEnd(in peekView: PeekView)
}

internal class PeekView: UIView {
    
    internal weak var delegate: PeekViewDelegate?
    internal var allowsMultipleSelection: Bool = false
    
    internal private(set) var viewModels: [UIView] = []
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
    
    private lazy var primarySelectionView: PeekSelectionView = {
        let view = PeekSelectionView(borderColor: .primaryTint, borderWidth: 1.5)
        addSubview(view)
        return view
    }()
    
    private lazy var secondarySelectionView: PeekSelectionView = {
        let view = PeekSelectionView(borderColor: .white, borderWidth: 1.5)
        addSubview(view)
        return view
    }()
    
    internal init() {
        super.init(frame: .zero)
        
        addGestureRecognizer(panGesture)
        addGestureRecognizer(tapGesture)
        addGestureRecognizer(doubleTapGesture)
        
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
    
    internal func updateHighlights(animated: Bool) {
        guard let primary = indexesForSelectedItems.last else { return }
        let primaryFrame = viewModels[primary].frameInPeek(self)
        var secondaryFrame = CGRect.zero
        
        if indexesForSelectedItems.count > 1, let secondary = indexesForSelectedItems.first {
            secondaryFrame = viewModels[secondary].frameInPeek(self)
        }
        
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
