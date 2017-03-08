//
//  EventTableViewCell.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 8/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var mEventIdLabel: UILabel!
    @IBOutlet weak var mVenueLabel: UILabel!
    @IBOutlet weak var mNameLabel: UILabel!
    @IBOutlet weak var mSpeakerLabel: UILabel!
    @IBOutlet weak var mBuildingNameLabel: UILabel!
    
    @IBOutlet weak var mVenueStackView: UIStackView!
    @IBOutlet weak var mNameStackView: UIStackView!
    @IBOutlet weak var mSpeakerStackView: UIStackView!
    @IBOutlet weak var mBuildingStackView: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func buildUI(event : Events) -> Void {
        mEventIdLabel.text       =   "\(event.mEventId as Int)"
        mVenueLabel.text         =   event.mVenue   as String
        mNameLabel.text          =   event.mName    as String
        mSpeakerLabel.text       =   event.mSpeaker as String
        mBuildingNameLabel.text  =   event.mBuildingName as String
        
        /*if(event.mVenue == "") {
            mVenueStackView.isHidden = true
        }
        if event.mName == "" {
            mNameStackView.isHidden = true
        }
        if event.mSpeaker == "" {
            mSpeakerStackView.isHidden = true
        }
        if event.mBuildingName == "" {
            mBuildingStackView.isHidden = true
        }*/
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
