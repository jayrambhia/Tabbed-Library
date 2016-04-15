//
//  BookTableViewCell.swift
//  Tabbed Library
//
//  Created by admin on 4/15/16.
//  Copyright © 2016 Elanic. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var subtitleView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
