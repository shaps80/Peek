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
import OpenSans
import pop

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ButtonDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var stackContainerView: UIView!
    
    fileprivate var previousWeekNumber = 1
    
    @IBOutlet var chestLabel: UILabel! {
        didSet {
            chestLabel.alpha = 0
        }
    }
    
    @IBOutlet var waistLabel: UILabel! {
        didSet {
            waistLabel.alpha = 0
        }
    }
    
    @IBOutlet var hipsLabel: UILabel! {
        didSet {
            hipsLabel.alpha = 0
        }
    }
    
    @IBOutlet var waistButton: Button! {
        didSet {
            waistButton.delegate = self
        }
    }
    
    @IBOutlet var hipsButton: Button! {
        didSet {
            hipsButton.delegate = self
        }
    }
    
    @IBOutlet var chestButton: Button! {
        didSet {
            chestButton.delegate = self
        }
    }
    
    let model = Model()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        
        hipsButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "tick"))
        collectionViewTopConstraint.constant = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.previousWeekNumber = -1
            
            let animation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            animation?.toValue = -100
            animation?.springBounciness = 10
            animation?.springSpeed = 20
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
                let index = self.model.weeks.index(of: self.model.currentWeek())!
                let indexPath = IndexPath(item: index, section: 0)
                self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                
                self.updateSelection(true)
            }
            
            self.collectionViewTopConstraint.pop_add(animation, forKey: "constraint")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let week = selectedWeek()
        ImageCache.sharedCache().addImage(image, week: week)
        
        ImageCache.sharedCache().image(week) { (image) -> () in
            self.setImage(image, animated: true)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if hipsButton.textField.isFirstResponder || waistButton.textField.isFirstResponder || chestButton.textField.isFirstResponder {
            endEditing()
            return
        }
        
        if let view = gesture.view, view === stackContainerView {
            return
        }
        
        let week = selectedWeek()
        
        if !ImageCache.sharedCache().imageExists(week) {
            showImagePicker()
            return
        }
        
        let controller = UIAlertController(title: "Update Image", message: "Would you like to choose a new image or remove the existing one?", preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        controller.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { (action) -> Void in
            self.showImagePicker()
        }))
        
        controller.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { (action) -> Void in
            self.setImage(nil, animated: true)
            ImageCache.sharedCache().removeImage(week)
        }))
        
        present(controller, animated: true, completion: nil)
    }
    
    func showImagePicker() {
        let controller = UIImagePickerController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    func setImage(_ image: UIImage?, animated: Bool) {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.1
        imageView.layer.add(transition, forKey: "fade")
        
        if image != nil {
            imageView.contentMode = .scaleAspectFill
            imageView.image = image
        } else {
            imageView.contentMode = .center
            imageView.image = UIImage(named: "photos")
        }
        
        if animated {
            let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            animation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
            animation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.2, y: 1.2))
            animation?.springBounciness = 20
            animation?.springSpeed = 10
            imageView.pop_add(animation, forKey: "bounce")
        }
        
        let week = selectedWeek()
        let index = model.weeks.index(of: week)!
        let indexPath = IndexPath(item: index, section: 0)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? WeekCell {
            configureCell(cell, indexPath: indexPath)
        }
        
        collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: UICollectionViewScrollPosition())
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.weeks.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeekCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: WeekCell, indexPath: IndexPath) {
        let week = model.weeks[indexPath.item]
        let isCurrent = week == model.currentWeek()
        
        cell.titleLabel.text = "\(week.number)"
        
        if isCurrent {
            cell.imageView.image = UIImage(named: "dot")
        } else {
            cell.imageView.image = model.complete(week) ? UIImage(named: "tick") : nil
        }
        
        cell.separatorView.isHidden = indexPath.item == model.weeks.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        endEditing()
        reloadView()
    }
    
    func button(_ button: Button, didChangeValue value: Double?) {
        var week = model.weeks[previousWeekNumber - 1]
        
        if button === waistButton {
            week.waist = value
        }
        
        if button === hipsButton {
            week.hips = value
        }
        
        if button === chestButton {
            week.chest = value
        }
        
        model.updateWeek(week)
        button.setValue(value, animated: true)
        updateSelection(true)
    }
    
    func reloadView() {
        let week = selectedWeek()
        
        var buttons: [[Button: Double?]]!
        var labels: [UILabel]!
        
        if week.number != previousWeekNumber {
            if week.number > previousWeekNumber {
                buttons = [ [chestButton: week.chest], [waistButton: week.waist], [hipsButton: week.hips] ]
                labels = [ chestLabel, waistLabel, hipsLabel ]
            } else {
                buttons = [ [hipsButton: week.hips], [waistButton: week.waist], [chestButton: week.chest] ]
                labels = [ hipsLabel, waistLabel, chestLabel ]
            }
            
            var delay: Double = 0
            
            for i in 0..<buttons.count {
                let attributes = buttons[i]
                
                let button = attributes.keys.first!
                let value = attributes.values.first!
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
                    button.setValue(value, animated: true)
                    
                    let label = labels[i]
                    let animation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
                    animation?.duration = 0.5
                    animation?.toValue = 1
                    label.pop_add(animation, forKey: "alpha")
                }
                
                delay += 0.1
            }
            
            previousWeekNumber = week.number
        }
        
        ImageCache.sharedCache().image(week) { (image) -> () in
            self.setImage(image, animated: false)
        }
    }
    
    func updateSelection(_ animated: Bool) {
        let week = selectedWeek()
        
        reloadView()
        
        let index = model.weeks.index(of: week)!
        let indexPath = IndexPath(item: index, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) as? WeekCell {
            configureCell(cell, indexPath: indexPath)
        }
    }
    
    func selectedWeek() -> Week {
        let indexPath = collectionView.indexPathsForSelectedItems!.first!
        return model.weeks[indexPath.item]
    }
    
}

// MARK: Peek
extension ViewController {
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        // iOS 10 now requires device motion handlers to be on a UIViewController
        view.window?.peek.handleShake(motion)
    }
    
}
