//
//  PastViewController.swift
//  SaiKailash
//
//  Created by abilashr on 6/10/17.
//  Copyright © 2017 abilashr. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PastEventsController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet var tableView: UITableView!
    var ref: DatabaseReference!
    
    
    var list = [String]()
    var current = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list.append("Loading ...")
        ref = Database.database().reference()
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy"
        let currentYear = Int(formatter.string(from: date) )
        formatter.dateFormat = "MM"
        let currentMonth = Int(formatter.string(from: date) )
        formatter.dateFormat = "dd"
        let currentDate = Int(formatter.string(from: date) )
        
        ref.child("events/upcoming").observeSingleEvent(of: .value, with: { (snapshot) in
            for year in snapshot.children{
                let yearCheck = Int((year as! DataSnapshot).key )
                if(yearCheck! >= currentYear!){
                    for month in (year as! DataSnapshot).children{
                        let monthCheck = Int((month as! DataSnapshot).key )
                        if(monthCheck! >= currentMonth!){
                            for day in (month as! DataSnapshot).children{
                                let dateCheck = Int((day as! DataSnapshot).key )
                                if((monthCheck! == currentMonth! && dateCheck! >= currentDate!) || monthCheck! > currentMonth!){
                                }else{
                                    let dayObject = (day as! DataSnapshot).value as? NSDictionary
                                    let date = dayObject?["date"] as! String
                                    let message = dayObject?["message"] as! String
                                    self.current.append(date+"   "+message)
                                }
                            }
                        }
                        if(monthCheck! < currentMonth!){
                            for day in (month as! DataSnapshot).children{
                                let dayObject = (day as! DataSnapshot).value as? NSDictionary
                                let date = dayObject?["date"] as! String
                                let message = dayObject?["message"] as! String
                                self.current.append(date+"   "+message)
                            }
                        }
                    }
                }
                self.list = self.current
                self.list.reverse()
                self.tableView.reloadData()
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cell.textLabel?.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cell.textLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        cell.backgroundColor = UIColor(red: 69/255, green: 90/255, blue: 100/255, alpha: 1.0)
        cell.textLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        return(cell)
    }
    
}
