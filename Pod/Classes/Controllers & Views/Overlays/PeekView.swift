//
//  PeekView.swift
//  Peek
//
//  Created by Shaps Benkau on 11/03/2018.
//

import UIKit

internal final class PeekSelectionView: UIView {
    
}

internal protocol ViewModel: Peekable, Model { }

internal protocol PeekViewDelegate: class {
    func viewModels(in peekView: PeekView) -> ViewModel
    func didSelect(viewModel: ViewModel, in peekView: PeekView)
}

internal final class PeekView: UIView {
    
    internal weak var delegate: PeekViewDelegate?
    internal var allowsMultipleSelection: Bool = false
    internal private(set) var indexesForSelectedItems: IndexSet?
    
    private var isDragging: Bool = false
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
    
    private lazy var doubleTapGesture: PeekTapGestureRecognizer = {
        let gesture = PeekTapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        gesture.numberOfTapsRequired = 2
        return gesture
    }()
    
    internal init() {
        super.init(frame: .zero)
        
        addGestureRecognizer(panGesture)
        addGestureRecognizer(tapGesture)
        addGestureRecognizer(doubleTapGesture)
        tapGesture.require(toFail: doubleTapGesture)
        
        observer = NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: .main) { [weak self] _ in
            // we have to add a delay to allow the app to finish updating its layout.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.refresh()
            }
        }
    }
    
    internal func refresh() {
        
    }
    
    internal func selectItem(at index: Int, animated: Bool) {
//        indexesForSelectedItems?.insert(index)
    }
    
    internal func deselectItem(at index: Int, animated: Bool) {
//        indexesForSelectedItems?.remove(index)
    }
    
    private func configureView(_ view: PeekSelectionView, at index: Int) {
        // update its location based on model
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            if #available(iOS 10.0, *) {
                feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                haptic()?.prepare()
            }
            
//            updateBackgroundColor(alpha: 0.3)
            isDragging = true
//            setAttributesButton(hidden: true, animated: true)
        case .changed:
            break
//            updateSelectedModels(gesture)
        default:
            isDragging = false
//            updateBackgroundColor(alpha: 0.5)
//            let hidden = overlayView.selectedModels.count == 0
//            setAttributesButton(hidden: hidden, animated: true)

            feedbackGenerator = nil
        }
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if gesture === doubleTapGesture {
//                if let model = overlayView.selectedModels.last {
//                    presentInspectorsForModel(model)
//                }
            } else {
//                updateSelectedModels(gesture)
//
//                let hidden = overlayView.selectedModels.count == 0
//                setAttributesButton(hidden: hidden, animated: true)
            }
        }
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
