//
//  EventDetailController.swift
//  SaiKailash
//
//  Created by abilashr on 7/6/17.
//  Copyright © 2017 abilashr. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventDetailController: UIViewController {
    var ref: DatabaseReference!
    
    var selectedEvent: String!
    var selectedType: String!
    var selectedMessage: String!
    var selectionString: String!
    
    @IBOutlet var eventNameDisplay: UITextView!
    @IBOutlet var dateDisplay: UITextView!
    
    @IBOutlet var eventDetailDesc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.title = selectedType.capitalized
        self.dateDisplay.text = selectedEvent
        self.eventNameDisplay.text = selectedMessage
        
        ref.child("events/upcoming/"+selectionString).observeSingleEvent(of: .value, with: { (snapshot) in
            let detailObject = (snapshot ).value as? NSDictionary
            var detail = "Details will be updated soon. Stay tuned."
            if((detailObject?["detail"] as? String) != nil){
            detail = detailObject?["detail"] as! String
            }
            self.eventDetailDesc.text = detail
        }){ (error) in
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(false, animated: false)
        
        
    }
    
}

