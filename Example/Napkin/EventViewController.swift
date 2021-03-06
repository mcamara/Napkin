//
//  EventViewController.swift
//  Napkin
//
//  Created by Daniel Green on 05/07/2015.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import XLForm
import Luncheon
import Napkin

class EventViewController: NapkinViewController {
    var event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func saveWasTapped() {
        event.save {
            super.saveWasTapped()
        }
    }
    
    override func subject() -> Lunch {
        return self.event
    }
    
    override func setupFields() {
        input("title")
        input("secret", type: .Password)
        input("location")
        
        sectionSeparator()
        
        input("allDay", label: "All-day")
        input("starts")
        input("ends")
        
        input("repeatInterval", label: "Repeat", collection: [
            0: "Never",
            1: "Every Day",
            2: "Every Week",
            3: "Every 2 Weeks",
            4: "Every Month",
            5: "Every Year"
        ])
        
        sectionSeparator()
        
        input("alert", collection: [
            0: "None",
            1: "At time of event",
            2: "5 minutes before",
            3: "15 minutes before",
            4: "30 minutes before",
            5: "1 hour before",
            6: "2 hours before",
            7: "1 day before",
            8: "2 days before"
        ])
        input("showAs", collection: [
            0: "Busy",
            1: "Free"
        ])
        
        sectionSeparator()
        
        input("URL", type: .URL)
        input("notes", type: .Text)
    }

}