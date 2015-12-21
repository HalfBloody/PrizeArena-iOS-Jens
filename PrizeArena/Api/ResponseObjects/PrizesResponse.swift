//
//  PrizesResponse.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 17/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import Foundation

import AlamofireObjectMapper
import ObjectMapper

class PrizesResponse : Mappable {
    var prizes : [PrizeElement]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        prizes <- map["prizes"]
    }
}

class PrizeElement : Mappable {
    var title : String?
    var prize_description : String?
    var id : Int?
    var start_date : NSDate?
    var end_date : NSDate?
    var total_slots : Int?
    var free_slots : Int?
    var image_path : String?
    var ticket_count : Int?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        let date_formatter = NSDateFormatter()

        title <- map["title"]
        prize_description <- map["prize_description"]
        id <- map["id"]
        start_date <- (map["start_date"], ISO8601DateTransform())
        end_date <- (map["end_date"], ISO8601DateTransform())
        total_slots <- map["total_slots"]
        free_slots <- map["free_slots"]
        image_path <- map["image_path"]
        ticket_count <- map["ticket_count"]
    }
}

public class ISO8601DateTransform: DateFormatterTransform {
    
    public init() {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss z" //"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            
        
        super.init(dateFormatter: formatter)
    }
    
}