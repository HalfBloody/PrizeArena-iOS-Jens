//
//  AccountCreator.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 08/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import RealmSwift

class AccountCreator {
    
    static func execute() ->Void {
        let user = User()
        user.updateKeys()
        Globals.user = user
        if user.token != "" {
            UserApiController.updateUser(user)
        } else {
            UserApiController.createUser(user)
        }
    }
}