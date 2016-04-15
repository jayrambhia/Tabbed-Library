//
//  BooksTableViewController.swift
//  Books
//
//  Created by admin on 4/15/16.
//  Copyright © 2016 Elanic. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    
    var author: [String: AnyObject]?
//    var books : [AnyObject] {
//        get {
//            if let books = author["Books"] as? [AnyObject] {
//                print(books)
//                return books
//            } else {
//                return [AnyObject]()
//            }
//        }
//    }
    
    lazy var books: [AnyObject] = {
        // Initialize books
        
        var buffer = [AnyObject]()
        if let author = self.author, let books = author["Books"] as? [AnyObject] {
            buffer += books
        } else {
            let filepath = NSBundle.mainBundle().pathForResource("Books", ofType: "plist")
            if let path = filepath {
                let authors = NSArray(contentsOfFile: path) as! [AnyObject]
                
                for author in authors {
                    if let books = author["Books"] as? [AnyObject] {
                        buffer += books
                    }
                }
            }
        }
        
        return buffer
    }()
    
    let cellIdentifier = "Book Cell"
    let segueBookCoverViewController = "BookCoverViewController"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Books", image: UIImage(named: "icon-books"), tag:1)
        tabBarItem.badgeValue = "8"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let author = author, let name = author["Author"] as? String {
            title = name
        } else {
            title = "Books"
        }
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookTableViewCell
        
        if let book = books[indexPath.row] as? [String: String] {
            if let title = book["Title"], let year = book["Year"], let cover = book["Cover"] {
                cell.titleView.text = title
                cell.subtitleView.text = year
                
                let image: UIImage = UIImage(named: cover)!
                cell.coverImageView.image = image
                cell.coverImageView.contentMode = .ScaleAspectFit
                
            } else {
                NSLog("Invalid title")
            }
        } else {
            NSLog("invalid book")
        }

        return cell
    }
    
    override
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // perform Segue
        performSegueWithIdentifier(segueBookCoverViewController, sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == segueBookCoverViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let book = books[indexPath.row] as? [String:String] {
                    let destinationViewController = segue.destinationViewController as! BookCoverViewController
                    destinationViewController.book = book
                }
            }
        }
    }


}
