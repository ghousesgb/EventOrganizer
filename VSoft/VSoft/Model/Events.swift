//
//  Events.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 8/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class Events: NSObject {
    var mEventId:Int
    var mVenue:String
    var mName:String
    var mSpeaker:String
    var mBuildingName:String
    
    override init() {
        mEventId        =   -1
        mVenue          =   ""
        mName           =   ""
        mSpeaker        =   ""
        mBuildingName   =   ""
    }
    
    init(eventId: Int, venue: String, name: String, speaker: String, buildingName: String) {
        mEventId        =   eventId
        mVenue          =   venue
        mName           =   name
        mSpeaker        =   speaker
        mBuildingName   =   buildingName
    }
    public func parseJson(json: [AnyObject]) -> [Events] {
        var completeEvent = [Events]()
        for jsonA  in json {
            completeEvent.append(Events(eventId: jsonA["eventID"] as! Int, venue: jsonA["venue"] as! String, name: jsonA["name"] as! String, speaker: jsonA["speakers"] as! String, buildingName: jsonA["buildingName"] as! String))
        }
        return completeEvent
    }
}

