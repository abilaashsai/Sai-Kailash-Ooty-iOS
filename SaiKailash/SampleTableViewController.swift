//
//  SampleTableViewController.swift
//  SaiKailash
//
//  Created by abilashr on 6/10/17.
//  Copyright © 2017 abilashr. All rights reserved.
//

import Foundation
import UIKit
class SampleTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var textView: UITableView!

    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list.append("Event 1")
        list.append("Event 2")
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


