//
//  Constants.swift
//  zTwitSplit
//
//  Created by dkan10 on 7/15/17.
//  Copyright © 2017 dkan10. All rights reserved.
//

import UIKit

// custom color will store here.
struct Color {
    static let mainColor = UIColor(red:0.23, green:0.23, blue:0.23, alpha:1.0)
    static let black = UIColor.black
    static let white = UIColor.white
    static let lightGray = UIColor.lightGray
}

// check Localizable.strings file.
struct MultiLanguage {
    static let tfUserName = NSLocalizedString("tfUserName", comment: "")
    static let btnStartChat = NSLocalizedString("btnStartChat", comment: "")
    static let pleaseEnterYourName = NSLocalizedString("pleaseEnterYourName", comment: "")
    static let sendMessagePlaceHolder = NSLocalizedString("sendMessagePlaceHolder", comment: "")
    static let sendMessageEmptyContent = NSLocalizedString("sendMessageEmptyContent", comment: "")
    static let sendMessageMustContainSpace = NSLocalizedString("sendMessageMustContainSpace", comment: "")
    static let dismiss = NSLocalizedString("dismiss", comment: "")
}
// help to detect current device.
struct DeviceConstants {
    
    // iPod
    static let MODEL_IPOD_TOUCH_5 = "iPod Touch 5"
    static let MODEL_IPOD_TOUCH_6 = "iPod Touch 6"
    
    // iPhone
    static let MODEL_IPHONE_4 = "iPhone 4"
    static let MODEL_IPHONE_4S = "iPhone 4s"
    static let MODEL_IPHONE_5 = "iPhone 5"
    static let MODEL_IPHONE_5C = "iPhone 5c"
    static let MODEL_IPHONE_5S = "iPhone 5s"
    static let MODEL_IPHONE_SE = "iPhone SE"
    static let MODEL_IPHONE_6 = "iPhone 6"
    static let MODEL_IPHONE_6S = "iPhone 6s"
    static let MODEL_IPHONE_6_PLUS = "iPhone 6 Plus"
    static let MODEL_IPHONE_6S_PLUS = "iPhone 6s Plus"
    static let MODEL_IPHONE_7 = "iPhone 7"
    static let MODEL_IPHONE_7_PLUS = "iPhone 7 Plus"
    
    // iPad
    static let MODEL_IPAD_2 = "iPad 2"
    static let MODEL_IPAD_3 = "iPad 3"
    static let MODEL_IPAD_4 = "iPad 4"
    static let MODEL_IPAD_AIR = "iPad Air"
    static let MODEL_IPAD_AIR_2 = "iPad Air 2"
    static let MODEL_IPAD_MINI = "iPad Mini"
    static let MODEL_IPAD__MINI_2 = "iPad Mini 2"
    static let MODEL_IPAD_MINI_3 = "iPad Mini 3"
    static let MODEL_IPAD_MINI_4 = "iPad Mini 4"
    static let MODEL_IPAD_PRO = "iPad Pro"
    
    // Simulator
    static let MODEL_IPHONE_SIMULATOR = "Simulator"
    
}



