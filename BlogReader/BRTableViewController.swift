//
//  BRTableViewController.swift
//  BlogReader
//
//  Created by Ravi Shankar on 31/07/14.
//  Copyright (c) 2014 Ravi Shankar. All rights reserved.
//

import UIKit

class BRTableViewController: UITableViewController, NSXMLParserDelegate {

    var parser: NSXMLParser = NSXMLParser()
    var blogPosts: [BlogPost] = []
    var postTitle: String = String()
    var postLink: String = String()
    var eName: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url:NSURL = NSURL(string: "http://rshankar.com/feed")!
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
    }
    
    // MARK: - NSXMLParserDelegate methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postLink = String()
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (!data.isEmpty) {
            if eName == "title" {
                postTitle += data
            } else if eName == "link" {
                postLink += data
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let blogPost: BlogPost = BlogPost()
            blogPost.postTitle = postTitle
            blogPost.postLink = postLink
            blogPosts.append(blogPost)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        let blogPost: BlogPost = blogPosts[indexPath.row]
        cell.textLabel?.text = blogPost.postTitle
        
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         return 50.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)  {
        if segue.identifier == "viewpost" {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let blogPost: BlogPost = blogPosts[selectedRow!]
            let viewController = segue.destinationViewController as! PostViewController
            viewController.postLink = blogPost.postLink
        }
    }
}
