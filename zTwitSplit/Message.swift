//
//  Message.swift
//  zTwitSplit
//
//  Created by dkan10 on 7/15/17.
//  Copyright © 2017 dkan10. All rights reserved.
//

import Foundation

struct Message {
    
    var sender: String?
    var time: String?
    var content: String?
    
    init(sender: String, time: String, content: String) {
        self.sender = sender
        self.time = time
        self.content = content
    }
}
