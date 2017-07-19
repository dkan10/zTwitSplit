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
    
    func shakeTextField(tf: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: tf.center.x - 10, y: tf.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: tf.center.x + 10, y: tf.center.y))
        tf.layer.add(animation, forKey: "position")
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
    
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
    
    func showAlert(vc: UIViewController, message: String) {
        let actionSheetController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction.init(title: MultiLanguage.dismiss, style: .cancel, handler: nil)
        actionSheetController.addAction(dismiss)
        vc.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    func splitMessage(message: String) -> [String] {
        var wordInMessageArr = message.components(separatedBy: charSpace)
        var messageArr = [String]()
        var prefixLength = 3
        var cont = false
        while (!cont) {
            var index = 10
            var t = 0
            prefixLength += 1
            var prefixLengthSub = prefixLength
            var partLengthMax = 0
            var currentMessage = ""
            for j in 0..<wordInMessageArr.count{
                t = j
                if (messageArr.count == index - 1) {
                    if (partLengthMax + prefixLengthSub + 1 > 50) {
                        messageArr = []
                        break
                    } else {
                        index *= 10
                        prefixLengthSub = prefixLengthSub + 2
                        partLengthMax = 0
                        let partLength = (currentMessage + charSpace + wordInMessageArr[j]).characters.count
                        if (partLength <= (50 - prefixLengthSub)) {
                            currentMessage = currentMessage + charSpace + wordInMessageArr[j]
                        } else {
                            if (wordInMessageArr[j].characters.count + prefixLengthSub) > 50 {
                                //                                return
                            }
                            messageArr.append(currentMessage)
                            if (currentMessage.characters.count >= partLengthMax) {
                                partLengthMax = currentMessage.characters.count
                            }
                            currentMessage = charSpace + wordInMessageArr[j]
                        }
                    }
                } else {
                    let partLength = (currentMessage + charSpace + wordInMessageArr[j]).characters.count
                    if (partLength <= (50 - prefixLengthSub)) {
                        currentMessage = currentMessage + charSpace + wordInMessageArr[j]
                    } else {
                        if ((wordInMessageArr[j].characters.count + prefixLengthSub) > 50) {
                            //                            return
                        }
                        messageArr.append(currentMessage)
                        if (currentMessage.characters.count >= partLengthMax) {
                            partLengthMax = currentMessage.characters.count
                        }
                        currentMessage = charSpace + wordInMessageArr[j]
                    }
                }
            }
            if (t+1 == wordInMessageArr.count) {
                cont = true
                messageArr.append(currentMessage)
            }
        }
        
        for i in 0..<messageArr.count {
            let first = String(i + 1)
            let last = String(messageArr.count)
            messageArr[i] = first + "/" + last + messageArr[i]
        }
        return messageArr
    }
    
    
}
