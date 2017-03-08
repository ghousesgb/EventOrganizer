//
//  Utilities.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 8/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class Utilities: NSObject {

}
extension URLRequest {
    mutating func setAuthorizationHeader(){
        let data = "vsoft:!vsoft@2o15".data(using: String.Encoding.utf8)
        
        if let base64 = data?.base64EncodedString(options: []) {
            setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        }
    }
}
