//
//  EventsViewController.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 8/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    var events = [Events]()
    var searchActive : Bool = false
    var filtered:[Events] = []

    @IBOutlet weak var mEventsTableView: UITableView!
    @IBOutlet weak var mSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeRequest()
        self.mEventsTableView.rowHeight = UITableViewAutomaticDimension
        self.mEventsTableView.estimatedRowHeight = 185;

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EventsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = self.events.filter({ (event:Events) -> Bool in
            let tmp: String = "\(event.mEventId)"
            let range = tmp.range(of: searchText, options:.caseInsensitive)
            return (range != nil)
        })
        
        if(searchText == "") {
            searchActive = false
        }

        DispatchQueue.main.async{
            self.mEventsTableView.reloadData()
        }
    }
}

extension EventsViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            return filtered.count
        }
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        let row = indexPath.row
        if row % 2 == 0 {
            cell.backgroundColor = UIColor.gray
        }else {
            cell.backgroundColor = UIColor.lightGray
        }
        if(searchActive){
            cell.buildUI(event: filtered[row])
        } else {
            cell.buildUI(event: events[row])
        }
        cell.layoutIfNeeded()
        return cell
    }
}

extension EventsViewController {
    func makeRequest() -> Void {
        
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        let HTTPHeaderField_ContentType         = "Content-Type"
        let ContentType_ApplicationJson         = "application/json"
        let HTTPMethod_Get                      = "GET"
        
        let callURL = URL.init(string: "https://mobileapps.vsoftconsulting.com:8443/TechFestEventWS/rest/events")
        
        var request = URLRequest.init(url: callURL!)
        
        request.timeoutInterval = 60.0 // TimeoutInterval in Second
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod_Get
        request.setAuthorizationHeader()
        
        let dataTask = urlSession.dataTask(with: request) { (data,response,error) in
            if error != nil{
                return
            }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [AnyObject] //Array<Dictionary<String, String>>
                print(resultJson)
                let eventJson = Events()
                let sortedArray = resultJson?.sorted {($0["eventID"] as! Int) < ($1["eventID"] as! Int)}
                self.events = eventJson.parseJson(json: sortedArray!)
                DispatchQueue.main.async{
                    self.mEventsTableView.reloadData()
                }
            } catch {
                print("Error -> \(error)")
            }
        }
        dataTask.resume()
    }
}
