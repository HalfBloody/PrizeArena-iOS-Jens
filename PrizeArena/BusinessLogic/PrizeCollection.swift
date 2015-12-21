//
//  PrizeCollection.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 14/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import RealmSwift


class PrizeCollection {
    
    class func fetchFromRealm() -> [PrizeModel]? {

        let not_ended = NSPredicate(format: "end_date = NIL OR end_date > %@", NSDate())
        let started = NSPredicate(format: "start_date < %@", NSDate())
        let predicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: [not_ended, started])
        let prizes = try! Realm().objects(PrizeModel).filter(predicate)
        return Array(prizes)
    }
}