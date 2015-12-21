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
    
    class func getPrizes(completionHandler : (String) -> Void) {
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
                .validate()
                .responseObject { (response: Response<PrizesResponse, NSError>) in
                    switch response.result {
                    case .Success( let prizesResponse):
                        savePrizesToDB(prizesResponse)
                        dispatch_async(dispatch_get_main_queue(), {
                            completionHandler("success")
                        })
                    case .Failure(let error):
                        // Errors:
                        print("ERRRRRROOOOR")
                        print(response.result.value)
                        print("PrizesApiController::getPrizes failed with error: \(error)")
                        dispatch_async(dispatch_get_main_queue(), {
                            completionHandler("error")
//                            let ac = UIAlertController(title: "FAILURE", message: "The app couldnt connect to the server", preferredStyle: .ActionSheet)
//                            let popover = ac.popoverPresentationController
//                            popover?.sourceView = currentView
//                            popover?.sourceRect = CGRect(x: 32, y:32, width: 64, height: 64)
                        })
                    }
            }
        })

    }
    
    static func savePrizesToDB(prizesResponse : PrizesResponse) -> Void {
        var prizeModels : [PrizeModel] = []
        let realm = try! Realm()
        let date_formatter = NSDateFormatter()
        if prizesResponse.prizes!.count > 0 {
            for prize in prizesResponse.prizes! {
                let prizeModel = PrizeModel()
                prizeModel.title = prize.title ?? ""
                print(prize.title)
                prizeModel.prize_description = prize.prize_description ?? ""
                print(prize.prize_description)
                prizeModel.prize_description = prize.prize_description ?? ""
                prizeModel.id = prize.id!
                print(prize.id)
                print(prize.start_date)
                prizeModel.start_date = prize.start_date!
                prizeModel.end_date = prize.end_date
                prizeModel.total_slots = prize.total_slots!
                prizeModel.free_slots = prize.free_slots!
                prizeModel.image_path = prize.image_path!
                prizeModel.ticket_count = prize.ticket_count!
                prizeModel.updated_at = NSDate()
                prizeModels.append(prizeModel)
            }

            try! realm.write {
                for p in prizeModels {
                    realm.add(p, update: true)
                }
            }
        }
    }
    
//    static func processGetPrizesResponse(prizes_json : JSON)-> [PrizeModel] {
//        var prizes : [PrizeModel] = []
//        let date_formatter = NSDateFormatter()
//        date_formatter.dateFormat = "yyyy-MM-dd HH:mm:ss z" // 2015-12-11 00:38:54 UTC
//        for (_, prize_json) : (String, JSON) in prizes_json["prizes"] {
//            let prize = PrizeModel()
//            print(prize_json)
//            prize.title = prize_json["title"].string ?? ""
//            prize.prize_description = prize_json["prize_description"].string!
//            prize.prize_description = prize_json["prize_description"].string!
//            prize.id = prize_json["id"].int!
//            if let start_date_json = prize_json["start_date"].string {
//                print(start_date_json)
//                prize.start_date = date_formatter.dateFromString(start_date_json)!
//            }
//            
//            if let end_date_json = prize_json["end_date"].string {
//                print(end_date_json)
//                prize.end_date = date_formatter.dateFromString(end_date_json)
//            }
//            prize.total_slots = prize_json["total_slots"].int!
//            prize.free_slots = prize_json["free_slots"].int!
//            prize.image_path = prize_json["image_path"].string!
//            prize.ticket_count = prize_json["ticket_count"].int!
//            prize.updated_at = NSDate()
//            let realm = try! Realm()
//            try! realm.write {
//                realm.add(prize, update: true)
//                prizes.append(prize)
//            }
//        }
//        return prizes
//    }
}