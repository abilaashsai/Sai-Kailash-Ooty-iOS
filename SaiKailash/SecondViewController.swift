//
//  SecondViewController.swift
//  SaiKailash
//
//  Created by abilashr on 6/6/17.
//  Copyright © 2017 abilashr. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    var ref: DatabaseReference!
    

    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
        ref.child("events/upcoming").observeSingleEvent(of: .value, with: { (snapshot) in
            for year in snapshot.children{
                for month in (year as! DataSnapshot).children{
                    for day in (month as! DataSnapshot).children{
                        var dayObject = (day as! DataSnapshot).value as? NSDictionary
                        var date = dayObject?["date"] as! String
                        var message = dayObject?["message"] as! String
                        self.list.append(date+"   "+message)
                    }
                }
                self.tableView.reloadData()
                
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        return(cell)
    }
    
}

