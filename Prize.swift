//
//  Prize.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 07/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import RealmSwift


class Prize: Object {
    var title = ""
    var prize_description = ""
    var id = 0
    var start_date = NSDate()
    var end_date : NSDate?
    var total_slots = 0
    var free_slots = 0
    var image_path = ""
    var user : User?
    var ticket_count = 0
    var updated_at = NSDate()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    override static func primaryKey() -> String {
        return "id"
    }
    
//    static func getPrizes(user: User) -> [Prize] {
//        PrizesApiController.getPrizes(user)
//        return []
//    }
}
