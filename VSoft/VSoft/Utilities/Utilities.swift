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
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        self.image = nil
        // check for cache
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
