//
//  DetailViewController.swift
//  GrabilityTest
//
//  Created by Ricardo on 4/6/16.
//  Copyright © 2016 ricardo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let transitionManager = DetailTransitionManager()
    var application = Application()

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rightsLabel: UILabel!
    @IBOutlet weak var rights: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var summary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.transitioningDelegate = self.transitionManager
        
        let url = NSURL(string:self.application.image)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            self.image.image = UIImage(data:data!)
        }
        
        self.name.text = self.application.name
        self.artist.text = self.application.artist
        self.price.text = "\(self.application.currency) \(self.application.price)"
        self.releaseDate.text = self.application.releaseDate
        self.rights.text = self.application.rights
        self.summary.text = self.application.summary
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closeAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}