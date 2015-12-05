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


class User {
    static let sharedInstance = User()
    
    var fb_token:String?
    var token:String?
    var idfa_enabled:Bool?
    var IDFA:String?
    var os_version:String?
    var device_kind:String?
    var platform:String?
    var bubbles: Int?
    var state: String?
    
    init() {
        self.idfa_enabled = isIDFAEnabled()
        self.IDFA = getIDFA()
        self.token = Globals.settings.objectForKey("token") as? String
        self.os_version = UIDevice.currentDevice().systemVersion
        self.device_kind = UIDevice.currentDevice().modelName
        self.platform = "ios"
        self.fb_token = "my_Fb_token"
        self.bubbles = 0
        self.state = ""
    }
    
    func create() -> Void {
        UserApiController.createUser(self)
    }
    
    func getIDFA() -> String? {
        if isIDFAEnabled() {
            return ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        } else {
            return nil
        }
    }
    
    func isIDFAEnabled() -> Bool {
        return ASIdentifierManager.sharedManager().advertisingTrackingEnabled
    }
    
    func loggedIn() -> Bool {
        if self.fb_token == nil {
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