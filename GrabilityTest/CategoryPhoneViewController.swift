//
//  ViewController.swift
//  GrabilityTest
//
//  Created by Ricardo on 4/5/16.
//  Copyright © 2016 ricardo. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategoryPhoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var categoriesTable: UITableView!
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Utilities.sharedInstance.createInfo()
        self.categories = Utilities.sharedInstance.getCategories()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView - Datasource
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("CategoryTableViewCell", forIndexPath: indexPath) as! CategoryTableViewCell
        
        let category = self.categories[indexPath.row]
        
        cell.categoryLabel.text = category.name
        
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
        
        categoriesTable.deselectRowAtIndexPath(indexPath, animated: true)
        
        let iPhoneStoryboard: UIStoryboard = UIStoryboard(name: "iPhoneStoryboard", bundle: nil)
        let viewController = iPhoneStoryboard.instantiateViewControllerWithIdentifier("ApplicationPhoneViewController") as! ApplicationPhoneViewController
        viewController.category = self.categories[indexPath.row].catagoryId
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

}

