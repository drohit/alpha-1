//
//  ViewController.swift
//  OpenClass
//
//  Created by MacBook on 2016-01-11.
//  Copyright © 2016 Ravindu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///terms/{term}/{subject}/{catalog_number}/schedule
        var term = "1161"
        var subject = "Math"
        var catalog_number = "136"
        var wanted_section = 4
        var s = "LEC 00" + String(wanted_section)
        
        let url = NSURL(string: "https://api.uwaterloo.ca/v2/terms/" + term + "/" + subject + "/" + catalog_number + "/schedule.json?key=0263b6b83ac199b9600e8adca70c8a6b")!
        
        var task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    if let blogs = json["data"] as? NSArray! {
                        
                        for blog in blogs{
                            
                            let sec = blog["section"] as! String
                            let e_total = blog["enrollment_total"] as! Int
                            let e_max = blog["enrollment_capacity"] as! Int
                            
                            // s = "LEC 004"
                            if (sec == s)
                            {
                                let seats = e_max - e_total
                                if(seats>0)
                                {
                                    print("There are \(seats) seats available for \(s)!");
                                    
                                    
                                    let instructor_dict = blog["classes"] as! NSArray
                                    
                                    //Getting Instructor Name
                                    for items in instructor_dict{
                                        let ins = (items["instructors"]) as! NSArray
                                        
                                        if (ins[0] as! String != ""){
                                            print(ins[0]);
                                           
                                        }
                                        
                                    }
                                    
                                }else{
                                    print("Sorry there are no seats available.");
                                }
                                
                            }
                        }
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
            }
            
            
        }
        
        task.resume()
        
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

