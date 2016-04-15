//
//  AuthorsViewController.swift
//  Books
//
//  Created by admin on 4/14/16.
//  Copyright © 2016 Elanic. All rights reserved.
//

import UIKit

class AuthorsViewController: UITableViewController {
    
    let CellIdentifier = "Author Cell"
    let SegueBooksViewController = "BooksTableViewController"
    
    var authors = [AnyObject]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Authors", image: UIImage(named: "icon-authors"), tag: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title
        title = "Authors"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let filePath = NSBundle.mainBundle().pathForResource("Books", ofType: "plist")
        
        if let path = filePath {
            authors = NSArray(contentsOfFile: path) as! [AnyObject]
//            print(authors)
        }
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        return authors.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Dequeue Resuable Cell
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! AuthorTableViewCell
        
        if let author = authors[indexPath.row] as? [String: AnyObject], let name = author["Author"] as? String {
            // Configure Cell
            cell.titleView.text = name
            if let books = author["Books"] {
                cell.subtitleView.text = "\(books.count) Books"
            }
        }
        
        return cell;
    }
    
    override
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Perform Segue
        performSegueWithIdentifier(SegueBooksViewController, sender: self)
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
        
        if segue.identifier == SegueBooksViewController {
            if let indexPath = tableView.indexPathForSelectedRow, let author = authors[indexPath.row] as? [String: AnyObject] {
                let destinationViewController = segue.destinationViewController as! BooksTableViewController
                destinationViewController.author = author
            } else {
                NSLog("invalid index in segue")
            }
        } else {
            NSLog("invalid segue")
        }
    }


}
