//
//  Prize.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 07/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import RealmSwift


class PrizeModel: Object {
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

    override static func primaryKey() -> String {
        return "id"
    }
}
