//
//  BookCoverViewController.swift
//  Books
//
//  Created by admin on 4/15/16.
//  Copyright © 2016 Elanic. All rights reserved.
//

import UIKit

class BookCoverViewController: UIViewController {
    
    @IBOutlet var bookCoverView: UIImageView!
    
    var book: [String: String]?
    
    lazy var bookCoverImage: UIImage? = {
        var image: UIImage?
        
        if self.book == nil {
            var buffer = [AnyObject]()
            let filePath = NSBundle.mainBundle().pathForResource("Books", ofType: "plist")
            if let path = filePath {
                let authors = NSArray(contentsOfFile: path) as! [AnyObject]
                for author in authors {
                    if let book = author["Books"] as? [AnyObject] {
                        buffer += book
                    }
                }
            }
            
            if buffer.count > 0 {
                let random = Int(arc4random()) % buffer.count
                if let book = buffer[random] as? [String: String] {
                    self.book = book
                }
            }
        }
        
        if let book = self.book, let filename = book["Cover"] {
            image = UIImage(named: filename)
        }
        
        return image
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Cover", image: UIImage(named: "icon-cover"), tag: 2)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let bookCoverImage = bookCoverImage {
            bookCoverView.image = bookCoverImage
            bookCoverView.contentMode = .ScaleAspectFit
        }
        
        if let book = book {
            title = book["Title"]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
