//
//  SearchViewController.swift
//  shopcarrental
//
//  Created by Sawyer Vaughan on 10/30/15.
//  Copyright © 2015 Sawyer Vaughan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    var pickupDatePicker : UIDatePicker!
    var dropoffDatePicker : UIDatePicker!
    var locationField : UITextField!
    var pickupLabel : UILabel!
    var dropoffLabel : UILabel!
    var locationLabel : UILabel!
    var resultsController : ResultsViewController
    
    init(resultsController: ResultsViewController) {
        self.resultsController = resultsController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let threeThirtyDays : NSTimeInterval = 60 * 60 * 24 * 330 // 330 days from now, max distance for hotwire
        var top = Dimens.search_top_padding + Dimens.nav_bar_height // keeps track of where to put views
        
        // creates all of the views with proper frame, then sets their text or placeholder variables
        self.locationLabel = UILabel(frame: CGRectMake(
            Dimens.search_padding,
            top,
            self.view.frame.width - Dimens.search_padding,
            Dimens.search_label_height))
        self.locationLabel.text = Strings.search_location_placeholder
        top += Dimens.search_padding + Dimens.search_label_height
        
        self.locationField = UITextField(frame: CGRectMake(
            Dimens.search_padding,
            top,
            self.view.frame.width - 2*Dimens.search_padding,
            Dimens.location_text_field_height))
        self.locationField.placeholder = Strings.search_location_placeholder
        self.locationField.delegate = self
        self.locationField.returnKeyType = .Done
        top += Dimens.search_padding + Dimens.location_text_field_height
        
        self.pickupLabel = UILabel(frame: CGRectMake(
            Dimens.search_padding,
            top,
            self.view.frame.width - 2*Dimens.search_padding,
            Dimens.search_label_height))
        self.pickupLabel.text = Strings.search_pickup_label
        top += Dimens.search_padding + Dimens.search_label_height
        
        self.pickupDatePicker = UIDatePicker(frame: CGRectMake(
            Dimens.search_padding,
            top,
            self.view.frame.width - 2*Dimens.search_padding,
            Dimens.date_picker_height))
        self.pickupDatePicker.minimumDate = NSDate()
        let oneDay : NSTimeInterval = 60 * 60 * 24
        self.pickupDatePicker.date = NSDate(timeIntervalSinceNow: oneDay)
        self.pickupDatePicker.maximumDate = NSDate(timeIntervalSinceNow: threeThirtyDays)
        self.pickupDatePicker.minuteInterval = 30
        top += Dimens.search_padding + Dimens.date_picker_height
        
        self.dropoffLabel = UILabel(frame: CGRectMake(
            Dimens.search_padding,
            top,
            self.view.frame.width - Dimens.search_padding,
            Dimens.search_label_height))
        self.dropoffLabel.text = Strings.search_dropoff_label
        top += Dimens.search_padding + Dimens.search_label_height
        
        self.dropoffDatePicker = UIDatePicker(frame: CGRectMake(
            Dimens.search_padding,
            top,
            self.view.frame.width - 2*Dimens.search_padding,
            Dimens.date_picker_height))
        self.dropoffDatePicker.minimumDate = NSDate()
        self.dropoffDatePicker.maximumDate = NSDate(timeIntervalSinceNow: threeThirtyDays)
        let twoDay : NSTimeInterval = 60 * 60 * 24 * 2
        self.dropoffDatePicker.date = NSDate(timeIntervalSinceNow: twoDay)
        self.dropoffDatePicker.minuteInterval = 30
        
        // add all subviews
        self.view.addSubview(self.locationLabel)
        self.view.addSubview(self.locationField)
        self.view.addSubview(self.pickupLabel)
        self.view.addSubview(self.pickupDatePicker)
        self.view.addSubview(self.dropoffLabel)
        self.view.addSubview(self.dropoffDatePicker)
        
        // setup navigation controller
        let done = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done")
        self.navigationItem.rightBarButtonItem = done
        self.navigationItem.title = Strings.search_view_controller_title
        
        // setup view 
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func done() {
        // get the dates
        let pickupDate = pickupDatePicker.date
        let dropoffDate = dropoffDatePicker.date
        
        // check if the input is valid
        if pickupDate.compare(dropoffDate) == .OrderedAscending && self.locationField.text != nil { // pickup date is earlier
            self.navigationController!.dismissViewControllerAnimated(true, completion: {
                let location = self.locationField.text!
                let helper = DateHelper()
                let startDate = helper.getDateFromDate(pickupDate)
                let pickupTime = helper.getHoursFromDate(pickupDate) + ":" + helper.getMinutesFromDate(pickupDate)
                let endDate = helper.getDateFromDate(dropoffDate)
                let dropoffTime = helper.getHoursFromDate(dropoffDate) + ":" + helper.getMinutesFromDate(dropoffDate)
                self.resultsController.searchResults(location, startDate: startDate, endDate: endDate, pickupTime: pickupTime, dropoffTime: dropoffTime)
            })
        } else {
            // display an alert, and then dismiss it after one second
            let alert = UIAlertController(title: Strings.search_error_title, message: Strings.search_error_message, preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: nil)
            let one_second = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC)*1))
            dispatch_after(one_second, dispatch_get_main_queue(), {
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // make the keyboard disappear after clicking done on it
        textField.resignFirstResponder()
        return false
    }

}
