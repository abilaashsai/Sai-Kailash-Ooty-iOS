//
//  FirstViewController.swift
//  SaiKailash
//
//  Created by abilashr on 6/6/17.
//  Copyright © 2017 abilashr. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirstViewController: UIViewController {
    var ref: DatabaseReference!
    
    @IBOutlet weak var thoughtDetail: UITextView!
    @IBOutlet weak var thoughtTitle: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("thought").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var value = snapshot.value as? NSDictionary
            var title = value?["title"] as! String
            var detail = value?["data"] as! String
            self.thoughtTitle.text = title;
            self.thoughtDetail.text = detail;
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

