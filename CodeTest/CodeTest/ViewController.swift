//
//  ViewController.swift
//  CodeTest
//
//  Created by Mitchell Phillips on 10/31/16.
//  Copyright © 2016 MitchellPhillips. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String:AnyObject]
typealias JSONArray = [JSONDictionary]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, NSURLConnectionDataDelegate {

    var d: NSMutableData = NSMutableData()
    
    var tData: NSArray = NSArray()
    
    var movieTableViewCell = MovieTableViewCell()
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        iTunesSearch(term: "Batman")
        print("searching")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func iTunesSearch (term: String) {
        // replace spaces with + symbol.
        var iTunesTerm = term.replacingOccurrences(of: " ", with: "+", options: String.CompareOptions.caseInsensitive, range: nil)
        print("term sent")
        print(term)
        // anything that is URL friendly should be escaped
        var escapedTerm = iTunesTerm.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        var path = "https://itunes.apple.com/search?term=\(escapedTerm! as String)&media=movie"
        print("term accepted")
        print(path)
        var url: URL = URL(string: path)!
        print(url)
        var rqst: NSURLRequest = NSURLRequest(url: url as URL)
        var ctn: NSURLConnection = NSURLConnection(request: rqst as URLRequest, delegate: self, startImmediately: false)!
        print("URL for searching iTunes API \(url)")
        ctn.start()
        print("starting search")
    }
    func ctn(receivedResponse: NSURLConnection!, receivedResponse response: URLResponse!) {
        // clear out the data object if a new request was received.
        self.d = NSMutableData()
    }
    
    func ctn(ctn: NSURLConnection!, receivedData d: NSData!) {
        // add the received data to the data object self.d.appendData(d)
    }
    func ctnFinishedLoading(ctn: NSURLConnection!) {
        // self.d should hold the resulting info, request is complete
        // received data is converted into an object through JSON deserialization
        var err: NSError
        var jResult: NSDictionary = JSONSerialization.jsonObject(with: d as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        if jResult.count>0 && jResult["results"].count>0 {
            var results: NSArray = jResult["results"] as! NSArray
            self.tData = results
            self.tableView.reloadData()
        }
    }
    
//    func ctnFinishedLoading(ctn: NSURLConnection!) {
//
//        var err: NSError
//        do {
//            var jResult = try JSONSerialization.jsonObject(with: d as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! JSONDictionary
//            if jResult.count > 0 {
//                var results: NSArray = jResult["results"] as! NSArray
//                self.tData = results
//                self.tableView.reloadData()
//            }
//
//            } catch {
//                print("unable to parse JSON")
//            }
//        
//        
//    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tData.count
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "movieCell")
        var rData: NSDictionary = self.tData[indexPath.row] as! NSDictionary
        cell.textLabel?.text = rData["trackName"] as? String
        var uString: NSString = (rData["artworkUrl60"] as? NSString)!
        var iURL: NSURL = NSURL(string: uString as String)!
        var iData: NSData = NSData(contentsOf: (iURL as? URL)!)!
        cell.imageView?.image = UIImage(data: iData as Data)
        var mRating: NSString = (rData["contentAdvisoryRating"] as? NSString)!
        cell.detailTextLabel?.text = mRating as String
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

