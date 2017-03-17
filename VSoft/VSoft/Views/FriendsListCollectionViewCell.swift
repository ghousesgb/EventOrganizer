//
//  FriendsListCollectionViewCell.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 17/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class FriendsListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mFriendImageView: UIImageView!
    @IBOutlet weak var mFullNameLabel: UILabel!
    
    func buildUI(fList : FriendList) -> Void {
        
        let fullName             =  fList.firstName + " " + fList.lastName
        mFullNameLabel.text      = fullName
        mFriendImageView.imageFromServerURL(urlString: fList.friendAvatar)

    }
    
}
