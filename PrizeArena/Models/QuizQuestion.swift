//
//  QuizQuestion.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 15/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import RealmSwift

class QuizQuestionModel : Object {
    dynamic var id = 0
    dynamic var text = ""
    
    
    override static func primaryKey() -> String {
        return "id"
    }
}