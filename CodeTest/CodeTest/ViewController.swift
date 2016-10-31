//
//  ViewController.swift
//  CodeTest
//
//  Created by Mitchell Phillips on 10/31/16.
//  Copyright © 2016 MitchellPhillips. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func iTunesSearch (term: String) {
        // replace spaces with + symbol.
        var iTunesTerm = term.replacingOccurrences(of: " ", with: "+", options: String.CompareOptions.caseInsensitive, range: nil)
        // anything that is URL friendly should be escaped
//        var escapedTerm = iTunesTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//        var escapedTerm = iTunesTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//        var path = "https://itunes.apple.com/search?term=\(escapedTerm)&media=software"
//        var url: NSURL = NSURL(string: path)
//        var rqst: NSURLRequest = NSURLRequest(URL: url)
//        var ctn: NSURLConnection = NSURLConnection(rqst: rqst, delegate: self, startImmediately: false)
//        println("URL for searching iTunes API \(url)")
//        ctn.start()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

