//
//  DetailViewController.swift
//  dpc
//
//  Created by Alexander on 07/03/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var authorOfPostImageView: UIImageView!
    @IBOutlet weak var authorOfPostLabel: UILabel!
    @IBOutlet weak var backButton: DesignableButton!
    @IBOutlet weak var textOfPostTextView: DesignableTextView!
    //buttons
    @IBOutlet weak var likeButton: DesignableButton!
    @IBOutlet weak var shareButton: DesignableButton!
    
    
    // needs to be refactored
    @IBOutlet weak var shareView: DesignableView!
    @IBOutlet weak var muskButton: UIButton!
    @IBOutlet weak var shareLabelsView: UIView!
    @IBOutlet weak var emailShareButton: DesignableButton!
    @IBOutlet weak var twitterShareButton: DesignableButton!
    @IBOutlet weak var facebookShareButton: DesignableButton!
    //
    
    
    var data = Array<Dictionary<String,String>>()
    var number = 0
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "detailToHome", sender: sender)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "detailToHome" {
            let controller = segue.destination as!DribbbleViewController
            controller.data = data
            controller.number = number
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorOfPostLabel.text = data[number]["author"]
        authorOfPostImageView.image = UIImage(named: data[number]["avatar"]!)
        mainImageView.image = UIImage(named: data[number]["image"]!)
        textOfPostTextView.text = data[number]["text"]
        
        backButton.alpha = 0
        
        muskButton.isHidden = true
        shareView.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        backButton.alpha = 1
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: - buttons
    
    var likeButtonTouched = false
    @IBAction func likeButtonDidTouch(_ sender: Any) {
        self.likeButton.setImage(#imageLiteral(resourceName: "like-fill"), for: .highlighted)
        if likeButtonTouched == false{
            likeButton.setImage(#imageLiteral(resourceName: "like-fill"), for: .normal)
            likeButtonTouched = true
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            self.likeButtonTouched = false
        }
    }
    
    @IBAction func shareButtonDidTouch(_ sender: Any) {
        shareLabelsView.alpha = 0
        shareView.isHidden = false
        showMask()
        
        shareView.animation = "slideUp"
        shareView.delay = 0.05
        shareView.duration = 0.5
        emailShareButton.animation = "slideUp"
        emailShareButton.delay = 0.10
        emailShareButton.duration = 0.5
        twitterShareButton.animation = "slideUp"
        twitterShareButton.delay = 0.15
        twitterShareButton.duration = 0.5
        facebookShareButton.animation = "slideUp"
        facebookShareButton.delay = 0.20
        facebookShareButton.duration = 0.5
        
        SpringAnimation.springWithDelay(duration: 0.5, delay: 0.25, animations: {
            self.shareLabelsView.alpha = 1})
        
//        SpringAnimation.spring(duration: 0.5) {
//            self.dialogView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        }
        
        shareView.animate()
        emailShareButton.animate()
        twitterShareButton.animate()
        facebookShareButton.animate()
    }

    @IBAction func muskButtonDidTouch(_ sender: Any) {
        SpringAnimation.spring(duration: 0.5, animations: {
            self.muskButton.alpha = 0
            self.shareView.alpha = 0
        })
        shareView.isHidden = true
    }
    
    // MARK: - secondary functions
    
    func showMask() {
        self.muskButton.isHidden = false
        self.muskButton.alpha = 0
        SpringAnimation.spring(duration: 0.5) {
            self.muskButton.alpha = 1
        }
    }
  
    
}
