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
    
    static func createUser(user: User) -> Void {
        let params = prepareCreateParams(user)
        let url = Globals.base_url + "users"
        Alamofire.request(.POST, url, parameters: params as [String: AnyObject], encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    print("successfully fetched created")
                    print(data)
                    let json = JSON(data)
                    if let token = json["user"]["token"].string {
                        print("there is json")
                        let realm = try! Realm()
                        try! realm.write {
                            print(token)
                            user.token = token
                        }
                        
                        Globals.settings.setObject(token, forKey: "token")
                    }
                case .Failure(let error):
                    print(url)
                    print(params)
                    print("UserApiController::updateUser failed with error: \(error)")
                }
        }
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
        return params
    }
    
    static func updateUser(user: User) -> Void {
        let params = prepareUpdateParams(user)
        let url = Globals.base_url + "users/me.json"
        Alamofire.request(.PUT, url, parameters: params as [String: AnyObject], encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    print("success")
                    print(data)
                case .Failure(let error):
                    print("UserApiController::updateUser failed with error: \(error)")
                }
        }
    }
    
    static func prepareUpdateParams(user: User) -> [String: AnyObject] {
        let device_kind = user.device_kind ?? ""
        let os_version = user.os_version ?? ""
        let params: [String: AnyObject] = [
            "device": [
                "platform": "ios",
                "device_kind": device_kind,
                "os_version": os_version
            ]
        ]
        return params
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
//                    print(data)
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
}