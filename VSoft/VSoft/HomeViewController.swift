//
//  HomeViewController.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 17/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var mFriendsData = [FriendList]()
    var currentScrollPage = 0
    @IBOutlet weak var mFriendsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeAPICall()
        performSegue(withIdentifier: "welcomePopupSegue", sender: nil)
    }
    
    @IBAction func leftBarButtonAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "welcomePopupSegue", sender: nil)
    }
    @IBAction func logoutButtoonAction(_ sender: UIBarButtonItem) {
        
        DispatchQueue.main.async{
            let alert = UIAlertController(title: "Event Orgainser", message: "Are You Sure? You want to Logout?", preferredStyle: .actionSheet)
            let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
            let yesAction = UIAlertAction(title: "YES", style: .destructive, handler: { (UIAlertAction) in
              self.logout()
            })
            alert.addAction(yesAction)
            alert.addAction(noAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        let buttonTag = sender.tag
        if buttonTag == 0 {
            if currentScrollPage != 0 {
                currentScrollPage -= 1
            }
        }
        if buttonTag == 1 {
            currentScrollPage += 1
            if currentScrollPage >= mFriendsData.count {
                currentScrollPage = 0
            }
            
        }
        let indexPath = NSIndexPath(row: currentScrollPage, section: 0)
        
        mFriendsCollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        
    }
    func logout() {
        UserDefaults.standard.removeObject(forKey: "TOKEN")
        
        let loginVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "loginVC_SID") as! LoginViewController
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        DispatchQueue.main.async{
            appDelegate.window?.rootViewController = loginVC
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController {
    func makeAPICall() {
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
                let friendsJson = FriendList()
                self.mFriendsData = friendsJson.parseJson(json: resultJson!["data"] as! [AnyObject])
                DispatchQueue.main.async{
                    self.mFriendsCollectionView.reloadData()
                }
            } catch {
                print("Error -> \(error)")
            }
        }
        dataTask.resume()
  
    }
}

extension HomeViewController : UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mFriendsData.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCell",  for: indexPath as IndexPath ) as! FriendsListCollectionViewCell
        let row = indexPath.row
        cells.buildUI(fList: self.mFriendsData[row])
        return cells
    }
    
    
}
