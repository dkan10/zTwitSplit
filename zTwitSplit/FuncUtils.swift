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

    
}
