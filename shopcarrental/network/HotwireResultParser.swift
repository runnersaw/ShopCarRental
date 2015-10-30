//
//  File.swift
//  shopcarrental
//
//  Created by Sawyer Vaughan on 10/26/15.
//  Copyright © 2015 Sawyer Vaughan. All rights reserved.
//

import Foundation

class HotwireResultParser : NSObject {
    
    func parse(data: NSData, callback: (Array<HotwireResult>? -> Void)) {
        var resultsArray = Array<HotwireResult>()
        
        // parse the json here
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            if let resultsJson = json["Result"] as? Array<AnyObject> { // check if exists
                for (var i=0; i<resultsJson.count; i++) { // iterate through
                    let result = HotwireResult()
                    let r = resultsJson[i]
                    
                    // get all relevent fields and assign to the result
                    if let link = r["DeepLink"] as? String {
                        result.link = link
                    }
                    if let subtotal = r["SubTotal"] as? String {
                        result.subtotal = subtotal
                    }
                    if let total = r["TotalPrice"] as? String {
                        result.total = total
                    }
                    if let carTypeCode = r["CarTypeCode"] as? String {
                        result.carTypeCode = carTypeCode
                    }
                    if let pickupDay = r["PickupDay"] as? String {
                        result.pickupDay = pickupDay
                    }
                    if let pickupTime = r["PickupTime"] as? String {
                        result.pickupTime = pickupTime
                    }
                    if let dropoffDay = r["DropoffDay"] as? String {
                        result.dropoffDay = dropoffDay
                    }
                    if let dropoffTime = r["DropoffTime"] as? String {
                        result.dropoffTime = dropoffTime
                    }
                    if let airport = r["PickupAirport"] as? String {
                        result.airport = airport
                    }
                    resultsArray.append(result)
                }
            } else {
                print("Error")
                return
            }
        
            // do the callback
            callback(resultsArray)
        } catch {
            print("Error parsing data")
            return
        }
        
    }
}