//
//  HotwireResultsCell.swift
//  shopcarrental
//
//  Created by Sawyer Vaughan on 10/30/15.
//  Copyright © 2015 Sawyer Vaughan. All rights reserved.
//

import UIKit

class HotwireResultCell: UITableViewCell {
    
    // create views
    var costLabel = UILabel()
    var locationLabel = UILabel()
    var pickupLabel = UILabel()
    var dropoffLabel = UILabel()
    
    var result : HotwireResult?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // add subviews
        self.addSubview(self.costLabel)
        self.addSubview(self.locationLabel)
        self.addSubview(self.pickupLabel)
        self.addSubview(self.dropoffLabel)
        
        // setup default drawing variables
        self.setDrawingVars()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getHeightForResult(result: HotwireResult) -> CGFloat {
        // For the uitableviewdelegate to know the height of the cell
        return Dimens.location_label_height + Dimens.time_label_height + 2*Dimens.result_cell_padding + Dimens.location_label_bottom_margin
    }
    
    func setDrawingVars() {
        // setup all of the variables associated with view display
        // setup font colors
        self.costLabel.textColor = UIColor.blackColor()
        self.locationLabel.textColor = UIColor.blackColor()
        self.pickupLabel.textColor = UIColor.blackColor()
        self.dropoffLabel.textColor = UIColor.blackColor()
        
        // setup font sizes
        self.locationLabel.font = UIFont.systemFontOfSize(Dimens.location_label_font_size)
        self.costLabel.font = UIFont.systemFontOfSize(Dimens.location_label_font_size)
        self.pickupLabel.font = UIFont.systemFontOfSize(Dimens.time_label_font_size)
        self.dropoffLabel.font = UIFont.systemFontOfSize(Dimens.time_label_font_size)
    }

    func configureCell(result: HotwireResult, tableView: UITableView) {
        // save the result, then build the views from that
        self.result = result
        
        setFrames(tableView.bounds)
        setLabels()
    }
    
    func setFrames(bounds: CGRect) {
        // sets the frames for each label
        self.locationLabel.frame = CGRectMake(
            Dimens.result_cell_padding,
            Dimens.result_cell_padding,
            bounds.width/2-Dimens.result_cell_padding,
            Dimens.location_label_height)
        self.costLabel.frame = CGRectMake(
            bounds.width/2,
            Dimens.result_cell_padding,
            bounds.width/2-Dimens.result_cell_padding,
            Dimens.location_label_height)
        self.pickupLabel.frame = CGRectMake(
            Dimens.result_cell_padding,
            Dimens.result_cell_padding + Dimens.location_label_height + Dimens.location_label_bottom_margin,
            bounds.width/2-Dimens.result_cell_padding,
            Dimens.time_label_height)
        self.dropoffLabel.frame = CGRectMake(
            bounds.width/2,
            Dimens.result_cell_padding + Dimens.location_label_height + Dimens.location_label_bottom_margin,
            bounds.width/2-Dimens.result_cell_padding,
            Dimens.time_label_height)
        
    }
    
    func setLabels() {
        // sets the views for each label
        self.costLabel.text = "$"+self.result!.total // TODO: Fix for international currencies
        self.locationLabel.text = "Location: "+self.result!.airport
        self.pickupLabel.text = self.result!.pickupDay + " " + self.result!.pickupTime
        self.dropoffLabel.text = self.result!.dropoffDay + " " + self.result!.dropoffTime
    }
}
