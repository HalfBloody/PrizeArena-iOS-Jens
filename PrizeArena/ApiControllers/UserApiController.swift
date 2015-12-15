//
//  UserApiController.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 04/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RealmSwift



class UserApiController {

    static func loginUser(user: User) -> Void {
        let params: [String: AnyObject] = [
        "token": user.token,
        "user": [
            "fb_token": "some_token"
            ]
        ]
        let url = Globals.base_url + "login"
        Alamofire.request(.POST, url, parameters: params, encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success(_):
                    print("success login")
                    user.updateStateToLoggedIn()
                case .Failure(let error):
                    print(url)
                    print(params)
                    print("UserApiController::loginUser failed with error: \(error)")
                }
        }
    }

    static func getUser(user: User) -> Void {
        let realm = try! Realm()
        let params = "token=" + user.token
        let url = Globals.base_url + "users/me.json?" + params
        print(url)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    print("success getting user")
                    let json = JSON(data)
                    if let bubbles = json["user"]["bubbles"].int {
                        try! realm.write {
                            user.bubbles = bubbles
                        }
                    }
                case .Failure(let error):
                    print("UserApiController::GetUser failed with error: \(error)")
                }
        }
    }
    
    static func createUser(user: User) -> Void {
        let params = prepareCreateParams(user)
        let url = Globals.base_url + "users"
        Alamofire.request(.POST, url, parameters: params as [String: AnyObject], encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    if let token = json["user"]["token"].string {
                        print("there is json")
                        Globals.settings.setObject(token, forKey: "user_token")
                        Globals.user!.token = token
                    }
                    if let bubbles = json["user"]["bubbles"].int {
                        Globals.settings.setObject(bubbles, forKey: "user_bubbles")
                        Globals.user!.bubbles = bubbles
                    }
                case .Failure(let error):
                    print(url)
                    print(params)
                    print("UserApiController::updateUser failed with error: \(error)")
                }
        }
    }
    
    static func updateUser(user: User) -> Void {
        let params = prepareUpdateParams(user)
        let url = Globals.base_url + "user/me"
        Alamofire.request(.PUT, url, parameters: params as [String: AnyObject], encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success(_):
//                    print("success")
//                    print(data)
                    return
                case .Failure(let error):
                    print(response)
                    print("UserApiController::updateUser failed with error: \(error)")
                }
        }
    }
    
    static func prepareUpdateParams(user: User) -> [String: AnyObject] {
        let params: [String: AnyObject] = [
            "token": user.token,
            "device": [
                "idfa": user.IDFA,
                "idfa_enabled": user.idfa_enabled,
                "platform": "ios",
                "device_kind": user.device_kind,
                "os_version": user.os_version,
                "fb_token": user.fb_token ?? ""
            ]
        ]
        return params
    }
    
    static func prepareCreateParams(user: User) -> [String: AnyObject] {
        let params: [String: AnyObject] = [
            "device": [
                "idfa": user.IDFA,
                "platform": "ios",
                "device_kind": user.device_kind,
                "os_version": user.os_version
            ]
        ]
        print(params)
        return params
    }
}