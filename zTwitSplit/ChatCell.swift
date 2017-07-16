//
//  ChatCell.swift
//  zTwitSplit
//
//  Created by dkan10 on 7/16/17.
//  Copyright © 2017 dkan10. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var lbSender: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var tvContent: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
