//
//  ArticleViewController.swift
//  SaiKailash
//
//  Created by abilashr on 6/11/17.
//  Copyright © 2017 abilashr. All rights reserved.
//
//
//  FirstViewController.swift
//  SaiKailash
//
//  Created by abilashr on 6/6/17.
//  Copyright © 2017 abilashr. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ArticleViewController: UIViewController {
    var ref: DatabaseReference!
    
    
    @IBOutlet var articleDetail: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("yuga").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var value = snapshot.value as? NSDictionary
            var articleDetail = value?["detail"] as! String
            self.articleDetail.text = articleDetail;
            
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


