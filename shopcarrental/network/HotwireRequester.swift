//
//  HotwireRequester.swift
//  shopcarrental
//
//  Created by Sawyer Vaughan on 10/26/15.
//  Copyright © 2015 Sawyer Vaughan. All rights reserved.
//

import Foundation

class HotwireRequester : NSObject {
    
    static let BASE_URL = "http://api.hotwire.com/v1/search/car"
    static let API_KEY = "v7s39w3582xm6vt68cpsv6ed"
    
    func requestFromHotwire(destination: String, startDate: String, endDate: String, pickupTime: String, dropoffTime: String, callback: (Array<HotwireResult>? -> Void)) {
        // encode the search parameters for url
        // This allowed character set is the standard URLHostAllowedCharacterSet plus / because hotwire likes / in param
        let allowedCharSet = NSCharacterSet(charactersInString: "#%<>[]\\{|}").invertedSet
        let dest = destination.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharSet)
        let start = startDate.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharSet)
        let end = endDate.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharSet)
        let pickup = pickupTime.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharSet)
        let dropoff = dropoffTime.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharSet)
        
        // create the url and add all url parameters
        var url = HotwireRequester.BASE_URL
        url = url + "?apikey="+HotwireRequester.API_KEY
        url = url + "&format=json"
        url = url + "&dest="+dest!
        url = url + "&startdate="+start!
        url = url + "&enddate="+end!
        url = url + "&pickuptime="+pickup!
        url = url + "&dropofftime="+dropoff!
        print(url)
        // create the http request
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // check for nil data
            if data == nil || data!.length == 0 {
                print("error")
                return
            }
            
            // create parser and parse
            let parser = HotwireResultParser()
            parser.parse(data!, callback: callback)
        }
        
        // perform the task
        task.resume()
    }
    
}