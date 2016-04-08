//
//  Utilities.swift
//  GrabilityTest
//
//  Created by Ricardo on 4/5/16.
//  Copyright © 2016 ricardo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Utilities {
    static let sharedInstance = Utilities()
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    //Sets the json information into the defaults variable.
    func createInfo(){
        
        let urlString = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
        
        if self.verifyUrl(urlString) {
            
            let jsonInfo = self.getJSON(urlString)
            let jsonOfUrl = JSON(data: jsonInfo)
            
            let applications = NSMutableArray()
            
            if jsonOfUrl["feed"]["entry"] != nil {
                
                for (_, applicationJson): (String, JSON) in jsonOfUrl["feed"]["entry"] {
                    let categoryId = applicationJson["category"]["attributes"]["im:id"].stringValue
                    let categoryName = applicationJson["category"]["attributes"]["label"].stringValue
                    let applicationId = applicationJson["id"]["attributes"]["im:id"].stringValue
                    let name = applicationJson["im:name"]["label"].stringValue
                    let image = applicationJson["im:image"][2]["label"].stringValue
                    let summary = applicationJson["summary"]["label"].stringValue
                    let price = applicationJson["im:price"]["attributes"]["amount"].stringValue
                    let currency = applicationJson["im:price"]["attributes"]["currency"].stringValue
                    let rights = applicationJson["rights"]["label"].stringValue
                    let link = applicationJson["link"]["attributes"]["href"].stringValue
                    let artist = applicationJson["im:artist"]["label"].stringValue
                    let releaseDate = applicationJson["im:releaseDate"]["attributes"]["label"].stringValue
                    
                    let newApplication = ["categoryId" : categoryId, "categoryName" : categoryName, "applicationId" : applicationId, "name" : name, "image" : image, "summary" : summary, "price" : price, "currency" : currency, "rights" : rights, "link" : link, "artist" : artist, "releaseDate" : releaseDate]
                    
                    applications.addObject(newApplication)
                    
                }
                
                self.defaults.setObject(applications, forKey: "applications")
                
            }
            
        }
        
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        return false
    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func getCategories() -> [Category]{
        
        var categories = [Category]()
        
        if let _ = self.defaults.objectForKey("applications") {
            
            let arrayApplications = self.defaults.objectForKey("applications") as! NSMutableArray
            
            for app in arrayApplications {
                
                let category = Category()
                
                category.catagoryId = app["categoryId"] as! String
                category.name = app["categoryName"] as! String
                
                if !(NSArray(array: categories) as! [Category]).contains({
                    (a) -> Bool in
                    return a.catagoryId == category.catagoryId
                }) {
                    categories.append(category)
                }
                
            }
        }
        
        return categories
        
    }
    
    func getApplicationsByCategory(categoriId : String) -> [Application]{
        
        var applications = [Application]()
        
        if let _ = self.defaults.objectForKey("applications") {
            
            let arrayApplications = self.defaults.objectForKey("applications") as! NSMutableArray
            
            for app in arrayApplications {
                
                if app["categoryId"] as! String == categoriId {
                    let application = Application()
                    
                    application.applicationId = app["applicationId"] as! String
                    application.name = app["name"] as! String
                    application.image = app["image"] as! String
                    application.summary = app["summary"] as! String
                    application.price = app["price"] as! String
                    application.currency = app["currency"] as! String
                    application.rights = app["rights"] as! String
                    application.link = app["link"] as! String
                    application.artist = app["artist"] as! String
                    application.releaseDate = app["releaseDate"] as! String
                    application.category = app["categoryId"] as! String
                    
                    if !(NSArray(array: applications) as! [Application]).contains({
                        (a) -> Bool in
                        return a.applicationId == application.applicationId
                    }) {
                        applications.append(application)
                    }
                }
            }
        }
        
        return applications
        
    }

}