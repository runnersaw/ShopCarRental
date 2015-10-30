//
//  HotwireResult.swift
//  shopcarrental
//
//  Created by Sawyer Vaughan on 10/26/15.
//  Copyright © 2015 Sawyer Vaughan. All rights reserved.
//

import Foundation

class HotwireResult : NSObject {
    // model class that holds data for a hotwire result
    var link : String = ""
    var subtotal : String = ""
    var total : String = ""
    var carTypeCode : String = ""
    var pickupDay : String = ""
    var pickupTime : String = ""
    var dropoffDay : String = ""
    var dropoffTime : String = ""
    var airport : String = ""
}