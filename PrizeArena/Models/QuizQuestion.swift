//
//  QuizQuestion.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 15/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import RealmSwift

class QuizQuestion : Object {
    dynamic var text = ""
    
    
    override static func primaryKey() -> String {
        return "id"
    }
}