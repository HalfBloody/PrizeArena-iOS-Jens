//
//  UserResponse.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 17/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class UserResponse : Mappable {
    var token : String?
    var bubbles : Int?
    required init?(_ map: Map) {
    
    }
    
    func mapping(map: Map) {
        token <- map["user"]["bubbles"]
    }
}