//
//  ApplicationPhoneViewController.swift
//  GrabilityTest
//
//  Created by Ricardo on 4/5/16.
//  Copyright © 2016 ricardo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ApplicationPhoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var applicationsTable: UITableView!
    
    var applications = [Application]()
    var category = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Utilities.sharedInstance.createInfo()
        self.applications = Utilities.sharedInstance.getApplicationsByCategory(self.category)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView - Datasource
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.applications.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ApplicationTableViewCell = tableView.dequeueReusableCellWithIdentifier("ApplicationTableViewCell", forIndexPath: indexPath) as! ApplicationTableViewCell
        
        let application = self.applications[indexPath.row]
        
        cell.applicationLabel.text = application.name
        
        let url = NSURL(string:application.image)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            cell.applicationImage.image = UIImage(data:data!)
        }
        
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.cornerRadius = 5.0
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
            },completion: { finished in
                UIView.animateWithDuration(0.1, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1,1,1)
                })
        })
        
        return cell
    }
    
    //function of tableviewdelegate, here all the trips are loaded
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        applicationsTable.deselectRowAtIndexPath(indexPath, animated: true)
        
        let detail : DetailViewController = UIStoryboard(name: "detailStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        detail.application = self.applications[indexPath.row]
        
        self.presentViewController(detail, animated: true) { 
            
        }
       
    }
  
    
}


