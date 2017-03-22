//
//  WebSerivceData.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 22/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class WebSerivceData  {
    static func makeAPICall(url : String, completion: @escaping ([String:AnyObject])->())  {
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        let HTTPHeaderField_ContentType         = "Content-Type"
        let ContentType_ApplicationJson         = "application/json"
        let HTTPMethod_Get                      = "GET"
        
        let callURL = URL.init(string: "https://reqres.in/api/users?page=2")
        var request = URLRequest.init(url: callURL!)
        request.timeoutInterval = 60.0 // TimeoutInterval in Second
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod_Get
        
        let dataTask = urlSession.dataTask(with: request) { (data,response,error) in
            if error != nil{
                return
            }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] //Array<Dictionary<String, String>>
                print(resultJson)
                    completion(resultJson!)
            } catch {
                print("Error -> \(error)")
            }
        }
        dataTask.resume()
    }
}


