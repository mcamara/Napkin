//
//  Event.swift
//  Napkin
//
//  Created by Daniel Green on 05/07/2015.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Luncheon

class Event: NSObject, Lunch {
    dynamic var title: String = ""
    dynamic var location: String = ""
    dynamic var allDay: Bool = false
    dynamic var starts: NSDate = NSDate(timeIntervalSinceNow: 60*60*24)
    dynamic var ends: NSDate = NSDate(timeIntervalSinceNow: 60*60*25)
    dynamic var repeatInterval: String = "Never"
    dynamic var alert: String = "None"
    dynamic var showAs: String = "Busy"
    dynamic var URL: String = ""
    dynamic var notes: String = ""
    
    required override init() {
        super.init()
    }
}