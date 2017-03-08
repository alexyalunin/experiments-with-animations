//
//  DribbbleViewController.swift
//  dpc
//
//  Created by Alexander on 06/03/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class DribbbleViewController: UIViewController {

    // MARK: - basic outlets
    
    @IBOutlet var globalViewOfVC: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var muskButton: UIButton!
    @IBOutlet weak var headerView: UIVisualEffectView!
    
    // dialog view
    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var titleOfPostLabel: UILabel!
    @IBOutlet weak var authorOfPostLabel: UILabel!
    @IBOutlet weak var authorOfPostImageView: UIImageView!
    @IBOutlet weak var mainImageButton: UIButton!
    @IBOutlet weak var likeButton: DesignableButton!
    @IBOutlet weak var shareButton: DesignableButton!
    
    // share view
    @IBOutlet weak var shareView: DesignableView!
    @IBOutlet weak var facebookShareView: SpringView!
    @IBOutlet weak var twitterShareView: SpringView!
    @IBOutlet weak var emailShareView: SpringView!
    @IBOutlet weak var shareLabel: SpringLabel!
    
    // menu view
    @IBOutlet weak var menuButton: DesignableButton!
    @IBOutlet weak var menuView: SpringView!

    // MARK: - constraints
    
    @IBOutlet weak var dialogViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var dialogViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dialogViewCenterVerticalyConstraint: NSLayoutConstraint!
    @IBOutlet weak var dialogViewCenterHorizontalyConstraint: NSLayoutConstraint!
    
    // MARK: - main functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        muskButton.isHidden = true
        menuView.isHidden = true
        shareView.isHidden = true
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "homeToDetail" {
            _ = segue.destination as! DetailViewController
            
        }
    }
    
    // MARK: - actions
    
    @IBAction func mainImageButtonDidTouch(_ sender: Any) {
        SpringAnimation.springWithCompletion(duration: 0.5, animations:
            {
                let globalWidth = self.globalViewOfVC.frame.width
                let globalHeight = self.globalViewOfVC.frame.height
                let imageHeight = globalWidth * 3/4
                
                self.dialogViewWidthConstraint.constant = globalWidth
                self.dialogViewHeightConstraint.constant = globalHeight
                
                self.dialogView.frame = CGRect(x: 0, y: 0, width: globalWidth, height: globalHeight)
                
                self.dialogView.layer.cornerRadius = 0
                self.mainImageButton.frame = CGRect(x: 0, y: 0, width: globalWidth, height: imageHeight)
                self.menuButton.alpha = 0
                self.likeButton.alpha = 0
                self.shareButton.alpha = 0
                self.headerView.alpha = 0
        }, completion:
            {
                finished in
                self.performSegue(withIdentifier: "homeToDetail", sender: self)
        })
    }
    
    @IBAction func muskButtonDidTouch(_ sender: Any) {
        SpringAnimation.spring(duration: 0.5) {
            self.muskButton.alpha = 0
        }
        hideShareView()
        hidePopover()
    }

    @IBAction func menuButtonDidTouch(_ sender: Any) {
        menuView.isHidden = false
        
        let scale = CGAffineTransform(scaleX: 0.3, y: 0.3)
        let translate = CGAffineTransform(translationX: 50, y: -50)
        menuView.transform = scale.concatenating(translate)
        menuView.alpha = 0
        
        showMask()
        
        SpringAnimation.spring(duration: 0.5) {
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let translate = CGAffineTransform(translationX: 0, y: 0)
            self.menuView.transform = scale.concatenating(translate)
            self.menuView.alpha = 1
        }
    }
    
    @IBAction func shareButtonDidTouch(_ sender: Any) {
        shareLabel.alpha = 0
        shareView.isHidden = false
        showMask()
        
        shareView.animation = "slideUp"
        shareView.delay = 0.05
        shareView.duration = 0.5
        emailShareView.animation = "slideUp"
        emailShareView.delay = 0.10
        emailShareView.duration = 0.5
        twitterShareView.animation = "slideUp"
        twitterShareView.delay = 0.15
        twitterShareView.duration = 0.5
        facebookShareView.animation = "slideUp"
        facebookShareView.delay = 0.20
        facebookShareView.duration = 0.5
        
        SpringAnimation.springWithDelay(duration: 0.5, delay: 0.25, animations: {
        self.shareLabel.alpha = 1})
        
        SpringAnimation.spring(duration: 0.5) {
            self.dialogView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
        shareView.animate()
        emailShareView.animate()
        twitterShareView.animate()
        facebookShareView.animate()
    }
    
    // MARK: - secondary functions
    
    func showMask() {
        self.muskButton.isHidden = false
        self.muskButton.alpha = 0
        SpringAnimation.spring(duration: 0.5) {
            self.muskButton.alpha = 1
        }
    }
    
    func hidePopover() {
        self.muskButton.alpha = 0
        SpringAnimation.spring(duration: 0.5) {
            self.menuView.isHidden = true
        }
    }
    
    func hideShareView() {
        SpringAnimation.spring(duration: 0.5, animations: {
            self.shareView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.dialogView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.shareView.isHidden = true
        })
    }
    
    // MARK: - gestures
    
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravityBehaviour : UIGravityBehavior!
    var snapBehavior : UISnapBehavior!
    
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    @IBAction func handleGesture(_ sender: AnyObject) {
       
        let myView = dialogView
        let boxLocation = sender.location(in: dialogView)
        let location = sender.location(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            if (snapBehavior != nil) {
                animator.removeBehavior(snapBehavior)
            }
            
            let centerOffset = UIOffsetMake(boxLocation.x - (myView?.bounds)!.midX, boxLocation.y - (myView?.bounds)!.midY);
            attachmentBehavior = UIAttachmentBehavior(item: myView!, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            
            animator.addBehavior(attachmentBehavior)
        }
            
        else if sender.state == UIGestureRecognizerState.changed {
            attachmentBehavior.anchorPoint = location
        }
            
        else if sender.state == UIGestureRecognizerState.ended {
            
            animator.removeBehavior(attachmentBehavior)
            
            snapBehavior = UISnapBehavior(item: myView!, snapTo: view.center)
            animator.addBehavior(snapBehavior)
            
            let translation = sender.translation(in: view)
            if translation.y > 100 {
                animator.removeAllBehaviors()
                
                let gravity = UIGravityBehavior(items: [dialogView])
                gravity.gravityDirection = CGVector(dx: 0, dy: 10)
                animator.addBehavior(gravity)
                
                delay(delay: 0.3) {
                    self.refreshView()
                }
            }
        }
    }


    var number = 0
    
    func refreshView() {
        number += 1
        if number > 3 {
            number = 0
        }
        
        animator.removeAllBehaviors()
        
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
        attachmentBehavior.anchorPoint = view.center
        
        dialogView.center = view.center
        viewDidAppear(true)
    }
    
    // MARK: - data
    
    var data = getData()
    
    
    
    
    
    
    
    
    
    
    
}
