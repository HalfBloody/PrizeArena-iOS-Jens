//
//  User.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 04/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import UIKit
import Foundation
import AdSupport
import Alamofire
import SwiftyJSON
import RealmSwift


class User : Object {
    static let sharedInstance = User()
    
    var fb_token = ""
    var token = ""
    var idfa_enabled = ASIdentifierManager.sharedManager().advertisingTrackingEnabled
    var IDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString ?? ""
    var os_version = UIDevice.currentDevice().systemVersion
    var device_kind = UIDevice.currentDevice().modelName
    var platform = "ios"
    var bubbles = 0
    var state = "initialized"
    
    func create() -> Void {
        UserApiController.createUser(self)
    }

    
    func loggedIn() -> Bool {
        if self.fb_token == "" {
            return false
        } else {
            return true
        }
    }
    func updateStateToLoggedIn() -> Void {
        self.state = "logged_in"
        print("user state updated to logged_in")
    }
}