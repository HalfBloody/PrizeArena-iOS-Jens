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
    dynamic var title = ""
    dynamic var prize_description = ""
    dynamic var id = 0
    dynamic var start_date = NSDate()
    dynamic var end_date : NSDate?
    dynamic var total_slots = 0
    dynamic var free_slots = 0
    dynamic var image_path = ""
    dynamic var ticket_count = 0
    dynamic var updated_at = NSDate()
    
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
