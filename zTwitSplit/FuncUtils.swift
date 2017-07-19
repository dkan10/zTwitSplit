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
    func splitMessage(mess: String) -> [String] {
        //xet cac dieu kiện cơ bản như mess <50 kí tự (return mess), một từ >50 kí tự (return error),...
        
        var arr_word = mess.components(separatedBy: " ")
        var hhh = 1
        var index = 0
        while (arr_word.count >= hhh) {
            hhh *= 10
            index += 1
            
        }
        var arr_mess = [String]()
        var prefix_length = 3
        var cont = false
        while (!cont) {
            var index2 = 10
            var t = 0
            prefix_length += 1
            var prefix_length_sub = prefix_length
            var part_length_max = 0
            var curmess = ""
            for j in 0..<arr_word.count{
                t = j
                if (arr_mess.count == index2 - 1) {
                    if (part_length_max + prefix_length_sub + 1 > 50) {
                        arr_mess = []
                        break
                    } else {
                        index2 *= 10
                        prefix_length_sub = prefix_length_sub + 2
                        part_length_max = 0
                        var part_length = (curmess + " " + arr_word[j]).characters.count
                        if (part_length <= (50 - prefix_length_sub)) {
                            curmess = curmess + " " + arr_word[j]
                        } else {
                            if (arr_word[j].characters.count + prefix_length_sub) > 50 {
//                                return
                            }
                            arr_mess.append(curmess)
                            if (curmess.characters.count >= part_length_max) {
                                part_length_max = curmess.characters.count
                            }
                            curmess = " " + arr_word[j]
                        }
                    }
                } else {
                    var part_length = (curmess + " " + arr_word[j]).characters.count
                    if (part_length <= (50 - prefix_length_sub)) {
                        curmess = curmess + " " + arr_word[j]
                    } else {
                        if ((arr_word[j].characters.count + prefix_length_sub) > 50) {
//                            return
                        }
                        arr_mess.append(curmess)
                        if (curmess.characters.count >= part_length_max) {
                            part_length_max = curmess.characters.count
                        }
                        curmess = " " + arr_word[j]
                    }
                }
            }
            if (t+1 == arr_word.count) {
                cont = true
                arr_mess.append(curmess)
            }
        }
        for i in 0..<arr_mess.count {
            let first = String(i + 1)
            let mid = String(arr_mess.count)
            arr_mess[i] = first + "/" + mid + arr_mess[i]
        }
        return arr_mess
    }
    
    
}
