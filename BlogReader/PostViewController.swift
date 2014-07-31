//
//  PostViewController.swift
//  BlogReader
//
//  Created by Ravi Shankar on 31/07/14.
//  Copyright (c) 2014 Ravi Shankar. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView:UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var postLink: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        let url: NSURL = NSURL(string: postLink)
        let request: NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(request)
        webView.delegate = self
    }
    
    func webViewDidStartLoad(webView: UIWebView!)  {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView!)  {
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
