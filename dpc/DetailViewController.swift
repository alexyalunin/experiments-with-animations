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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        backButton.alpha = 1
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
