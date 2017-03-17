//
//  LoginViewController.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 17/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mUsernameTextField: UITextField!
    @IBOutlet weak var mPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        guard (mUsernameTextField.text?.characters.count)!>2 else {
            showAlertMessage(message: "Username can't be empty")
            return
        }
        guard (mPasswordTextField.text?.characters.count)!>2 else {
            showAlertMessage(message: "Password can't be empty")
            return
        }
        loginAPI()
    }
    func showAlertMessage(message : String) -> Void {
         DispatchQueue.main.async{
            let alert = UIAlertController(title: "Event Orgainser", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LoginViewController {
    func loginAPI()  {
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        let HTTPHeaderField_ContentType         = "Content-Type"
        let ContentType_ApplicationJson         = "application/json"
        let HTTPMethod_POST                     = "POST"
        
        let callURL = URL.init(string: "https://reqres.in/api/login")
        var request = URLRequest.init(url: callURL!)
        request.timeoutInterval = 60.0 // TimeoutInterval in Second
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod_POST
        let parameter : [String : String] = [
            "email" : mUsernameTextField.text!,
            "password" : mPasswordTextField.text!
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject:parameter, options:[])
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            print(dataString)
            request.httpBody = data
            // do other stuff on success
            
        } catch {
            print("JSON serialization failed:  \(error)")
            showAlertMessage(message: "Error in sending data")
            return
        }
       
        let dataTask = urlSession.dataTask(with: request) { (data,response,error) in
            if error != nil{
                return
            }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject] //Array<Dictionary<String, String>>
                print(resultJson!)
                guard let token = resultJson?["token"] else {
                    self.showAlertMessage(message: "Sorry Token not available")
                    return
                }
                UserDefaults.standard.setValue(token, forKey: "TOKEN")

                let homeVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "HomeVC_Navigator") as! UINavigationController
                
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                 DispatchQueue.main.async{
                    appDelegate.window?.rootViewController = homeVC
                }
                
            } catch {
                print("Error -> \(error)")
            }
        }
        dataTask.resume()
    }
}
