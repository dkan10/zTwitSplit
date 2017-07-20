//
//  FuncUtils.swift
//  zTwitSplit
//
//  Created by dkan10 on 7/16/17.
//  Copyright © 2017 dkan10. All rights reserved.
//

import Foundation
import UIKit

class FuncUtils {
    
    private init() {}
    static let shared: FuncUtils = FuncUtils()
    let charSpace = " "
    
    // This func is use for something wrong from user input like wrong password, wrong email,...
    func shakeTextField(tf: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: tf.center.x - 10, y: tf.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: tf.center.x + 10, y: tf.center.y))
        tf.layer.add(animation, forKey: "position")
    }
    // This func help to get current date with format as below.
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
    
    // This func make tableView auto scroll from top to bottom.
    func tableViewScrollToBottom(animated: Bool, tableView:UITableView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = tableView.numberOfSections
            let numberOfRows = tableView.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    // When user want to show alert at somewhere, they need call this func.
    func showAlert(vc: UIViewController, message: String) {
        let actionSheetController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction.init(title: MultiLanguage.dismiss, style: .cancel, handler: nil)
        actionSheetController.addAction(dismiss)
        vc.present(actionSheetController, animated: true, completion: nil)
    }
    
    // When message length user > 50, this func will be call, it's can help to split message to many part with length <= 50
    func splitMessage(message: NSString) -> [String] {
        // Find "number of digit" of "number of short message"
        // Assume that number of short message is less than or equal 9
        // Means format string of index is "x/x ", it has 4 characters
        // Then max length of short message without index must be less than or equal 46
        // If number of short message is less than or equal 99
        // Means format string of index is "xx/xx ", it has at most 6 characters
        let messageLength = Double(message.length)
        var i = 0
        
        // Number of short message is not over 10^(i + 1)
        // i: "number of digit" of "number of short message"
        // Ex1: 9 (1 digit) < 10^1 = 10
        // Ex2: 99 (2 digits) < 10^2 = 100
        while ceil(messageLength / Double(46 - 2*i)) > pow(Double(10), Double(i + 1)) {
            i += 1
        }
        
        // Find total count of index char
        // Ex: If there are 2 short messages
        // Then "1/2 " + "2/2 " = 8 chars
        var segmentCount = Int(ceil(messageLength / Double(46 - 2*i)))
        var segmentCountStr = String(segmentCount) as NSString
        // Count of index char of short messages
        var totalIndexCharCount = 0
        // Count of index of short messages
        var totalIndexCount = 0
        // If there are 89 short messages
        // So there are 2 format strings for index part: "x/xx " and "xx/xx "
        // Then total char count = 4*(10^1 - 10^0) + 5*(89 - (10^1 - 10^0)) = 4*9 + 5*(89 - 9)
        for j in 1 ... segmentCountStr.length {
            if j == segmentCountStr.length {
                totalIndexCharCount += Int(j + segmentCountStr.length + 2) * (segmentCount - totalIndexCount)
            } else {
                let indexCount = Int(pow(Double(10), Double(j)) - pow(Double(10), Double(j - 1)))
                totalIndexCharCount += Int(j + segmentCountStr.length + 2) * indexCount
                totalIndexCount += indexCount
            }
        }
        
        // Length of message include in indexes
        let realMessageLength = messageLength + Double(totalIndexCharCount)
        // Number of short message
        segmentCount = Int(ceil(realMessageLength / Double(50)))
        segmentCountStr = String(segmentCount) as NSString
        
        var segmentArr = [NSString]()
        var cursorIndex = 0
        var index = 1
        // Count of char in short message without index
        var charCountInSegment = 50 - ((String(index) as NSString).length + segmentCountStr.length + 2)
        
        while (cursorIndex + charCountInSegment < Int(messageLength)) {
            var subMessage = message.substring(with: NSRange.init(location: cursorIndex, length: charCountInSegment)) as NSString
            
            // If the last char of short message or the first char of the next one is a space character, insert this short message into array
            // Unless, travel back from the last char in short message to find the space character
            if message.substring(with: NSRange.init(location: cursorIndex + charCountInSegment, length: 1)) != " " {
                while subMessage.substring(with: NSRange.init(location: subMessage.length - 1, length: 1)) != " " {
                    subMessage = subMessage.substring(with: NSRange.init(location: 0, length: subMessage.length - 1)) as NSString
                }
            }
            
            segmentArr.append(subMessage)
            cursorIndex += (subMessage as NSString).length
            charCountInSegment = 50 - ((String(index) as NSString).length + segmentCountStr.length + 2)
            index += 1
        }
        
        // Insert the last short message into array
        if cursorIndex != message.length {
            let subMessage = message.substring(with: NSRange.init(location: cursorIndex, length: message.length - cursorIndex)) as NSString
            segmentArr.append(subMessage)
        }
        
        index = 1
        segmentCount = segmentArr.count
        for i in 0 ..< segmentCount {
            let subMessageWithIndex = String(index) + "/" + String(segmentCount) + " " + (segmentArr[i] as String)
            segmentArr[i] = subMessageWithIndex as NSString
            index += 1
        }
        
        return segmentArr as [String]
    }
    
}
