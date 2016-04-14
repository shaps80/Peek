//
//  ViewController.swift
//  Track
//
//  Created by Shaps Mohsenin on 09/02/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit
import OpenSans
import pop

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ButtonDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var collectionViewTopConstraint: NSLayoutConstraint!
  @IBOutlet var stackContainerView: UIView!

  private var previousWeekNumber = 1
  
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
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    stackContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))

    collectionViewTopConstraint.constant = -collectionView.bounds.height
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
      self.previousWeekNumber = -1
      
      let animation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
      animation.toValue = 0
      animation.springBounciness = 10
      animation.springSpeed = 20
      
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
        let index = self.model.weeks.indexOf(self.model.currentWeek())!
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        self.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .CenteredHorizontally)
        
        self.updateSelection(true)
      }
      
      self.collectionViewTopConstraint.pop_addAnimation(animation, forKey: "constraint")
    }
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    let week = selectedWeek()
    ImageCache.sharedCache().addImage(image, week: week)
    
    ImageCache.sharedCache().image(week) { (image) -> () in
      self.setImage(image, animated: true)
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func handleTap(gesture: UITapGestureRecognizer) {
    if hipsButton.textField.isFirstResponder() || waistButton.textField.isFirstResponder() || chestButton.textField.isFirstResponder() {
      endEditing()
      return
    }
    
    if let view = gesture.view where view === stackContainerView {
      return
    }
    
    let week = selectedWeek()
    
    if !ImageCache.sharedCache().imageExists(week) {
      showImagePicker()
      return
    }
    
    let controller = UIAlertController(title: "Update Image", message: "Would you like to choose a new image or remove the existing one?", preferredStyle: .Alert)
    
    controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    
    controller.addAction(UIAlertAction(title: "Choose from Library", style: .Default, handler: { (action) -> Void in
      self.showImagePicker()
    }))
    
    controller.addAction(UIAlertAction(title: "Remove", style: .Destructive, handler: { (action) -> Void in
      self.setImage(nil, animated: true)
      ImageCache.sharedCache().removeImage(week)
    }))
    
    presentViewController(controller, animated: true, completion: nil)
  }
  
  func showImagePicker() {
    let controller = UIImagePickerController()
    controller.delegate = self
    presentViewController(controller, animated: true, completion: nil)
  }
  
  func endEditing() {
    view.endEditing(true)
  }
  
  func setImage(image: UIImage?, animated: Bool) {
    let transition = CATransition()
    transition.type = kCATransitionFade
    transition.duration = 0.1
    imageView.layer.addAnimation(transition, forKey: "fade")
    
    if image != nil {
      imageView.contentMode = .ScaleAspectFill
      imageView.image = image
    } else {
      imageView.contentMode = .Center
      imageView.image = UIImage(named: "photos")
    }

    if animated {
      let animation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
      animation.toValue = NSValue(CGPoint: CGPointMake(1, 1))
      animation.fromValue = NSValue(CGPoint: CGPointMake(1.2, 1.2))
      animation.springBounciness = 20
      animation.springSpeed = 10
      imageView.pop_addAnimation(animation, forKey: "bounce")
    }
    
    let week = selectedWeek()
    let index = model.weeks.indexOf(week)!
    let indexPath = NSIndexPath(forItem: index, inSection: 0)
    
    if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? WeekCell {
      configureCell(cell, indexPath: indexPath)
    }
    
    collectionView.selectItemAtIndexPath(indexPath, animated: animated, scrollPosition: .None)
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.weeks.count
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    view.endEditing(true)
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! WeekCell
    configureCell(cell, indexPath: indexPath)
    return cell
  }
  
  func configureCell(cell: WeekCell, indexPath: NSIndexPath) {
    let week = model.weeks[indexPath.item]
    let isCurrent = week == model.currentWeek()
    
    cell.titleLabel.text = "\(week.number)"
    
    if isCurrent {
      cell.imageView.image = UIImage(named: "dot")
    } else {
      cell.imageView.image = model.complete(week) ? UIImage(named: "tick") : nil
    }
    
    cell.separatorView.hidden = indexPath.item == model.weeks.count - 1
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    endEditing()
    reloadView()
  }
  
  func button(button: Button, didChangeValue value: Double?) {
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
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
          button.setValue(value, animated: true)
          
          let label = labels[i]
          let animation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
          animation.duration = 0.5
          animation.toValue = 1
          label.pop_addAnimation(animation, forKey: "alpha")
        }
        
        delay += 0.1
      }
      
      previousWeekNumber = week.number
    }
    
    ImageCache.sharedCache().image(week) { (image) -> () in
      self.setImage(image, animated: false)
    }
  }
  
  func updateSelection(animated: Bool) {
    let week = selectedWeek()
    
    reloadView()
    
    let index = model.weeks.indexOf(week)!
    let indexPath = NSIndexPath(forItem: index, inSection: 0)
    if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? WeekCell {
      configureCell(cell, indexPath: indexPath)
    }
  }
  
  func selectedWeek() -> Week {
    let indexPath = collectionView.indexPathsForSelectedItems()!.first!
    return model.weeks[indexPath.item]
  }
  
}

