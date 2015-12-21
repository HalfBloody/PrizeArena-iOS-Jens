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
import FBSDKLoginKit


class UserModel {
    var token = Globals.settings.stringForKey("user_token") ?? ""
    var bubbles = Globals.settings.integerForKey("user_bubbles") ?? 0
    var fb_token = Globals.settings.stringForKey("fb_token") ?? ""
    var idfa_enabled = ASIdentifierManager.sharedManager().advertisingTrackingEnabled
    var IDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString ?? ""
    var os_version = UIDevice.currentDevice().systemVersion
    var device_kind = UIDevice.currentDevice().modelName
    var platform = "ios"
    var state = Globals.settings.stringForKey("user_state") ?? ""
    
    func initialize() -> Void {
        return
    }
    
    func updateKeys()-> Void {
        if let current_token = FBSDKAccessToken.currentAccessToken() {
            fb_token = current_token.tokenString
        } else {
            fb_token = ""
        }
        
        idfa_enabled = ASIdentifierManager.sharedManager().advertisingTrackingEnabled
        IDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString ?? ""
        os_version = UIDevice.currentDevice().systemVersion
        device_kind = UIDevice.currentDevice().modelName
        Globals.settings.setValue(fb_token, forKey: "fb_token")
        Globals.settings.setValue(idfa_enabled, forKey: "idfa_enabled")
        Globals.settings.setValue(IDFA, forKey: "IDFA")
        Globals.settings.setValue(token, forKey: "user_token")
        Globals.settings.setValue(bubbles, forKey: "user_bubbles")
        Globals.settings.setValue(os_version, forKey: "os_version")
        Globals.settings.setValue(device_kind, forKey: "device_kind")
        Globals.settings.setValue(platform, forKey: "platform")
        Globals.settings.setValue(state, forKey: "user_state")
    }
    
    func updateStateToLoggedIn() -> Void {
        try!Realm().write {
            self.state = "logged_in"
        }
        print("user state updated to logged_in")
    }
}