//
//  FriendList.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 17/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class FriendList: NSObject {
    var firstName  : String 
    var lastName   : String
    var friendAvatar: String = ""
    override init() {
        firstName       =   ""
        lastName =   ""
        friendAvatar    =   ""
    }
    
    init(fname: String, lname: String, avatar: String) {
        firstName       =   fname
        lastName        =   lname
        friendAvatar    =   avatar
    }
    public func parseJson(json: [AnyObject]) -> [FriendList] {
        var completeList = [FriendList]()
        for jsonA  in json {
            completeList.append(FriendList(fname: jsonA["first_name"] as! String, lname: jsonA["last_name"] as! String, avatar: jsonA["avatar"]as! String))
        }
        return completeList
    }

}
