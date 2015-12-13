//
//  PrizesApiController.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 08/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class PrizesApiController {
    
    static func getPrizes(controller : PrizesViewController)-> Void {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            let user = Globals.user!
            let params: [String: AnyObject] = [
                "token": user.token,
                "user": [
                    "fb_token": user.fb_token
                ]
            ]
            let url = Globals.base_url + "prizes?token=" + user.token
            Alamofire.request(.GET, url)
                .responseJSON { response in
                    switch response.result {
                    case .Success( let data):
                        print("success fetch prizes")
                        let json = JSON(data)
                        let prizes = processGetPrizesResponse(json)
                        dispatch_async(dispatch_get_main_queue(), {
                            controller.updatePrizesTable(prizes)
                        })
                    case .Failure(let error):
                        print(url)
                        print(params)
                        print("PrizesApiController::getPrizes failed with error: \(error)")
                        dispatch_async(dispatch_get_main_queue(), {
                            
                        })
                    }
            }
        })

    }
    static func processGetPrizesResponse(prizes_json : JSON)-> [Prize] {
        var prizes : [Prize] = []
        let date_formatter = NSDateFormatter()
        date_formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ" // 2015-12-11 00:38:54 UTC
        for (_, prize_json) : (String, JSON) in prizes_json["prizes"] {
            let prize = Prize()
            print(prize_json)
            prize.title = prize_json["title"].string!
            prize.prize_description = prize_json["prize_description"].string!
            prize.prize_description = prize_json["prize_description"].string!
            prize.id = prize_json["id"].int!
            if let start_date_json = prize_json["start_date"].string {
                print(start_date_json)
                prize.start_date = date_formatter.dateFromString(start_date_json)!
            }
            
            if let end_date_json = prize_json["end_date"].string {
                print(end_date_json)
                prize.end_date = date_formatter.dateFromString(end_date_json)
            }
            prize.total_slots = prize_json["total_slots"].int!
            prize.free_slots = prize_json["free_slots"].int!
            prize.image_path = prize_json["image_path"].string!
            prize.ticket_count = prize_json["ticket_count"].int!
            prize.updated_at = NSDate()
            try! realm.write {
                realm.add(prize, update: true)
                prizes.append(prize)
            }
        }
        return prizes
    }
}