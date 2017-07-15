//
//  LoginVc.swift
//  zTwitSplit
//
//  Created by dkan10 on 7/15/17.
//  Copyright © 2017 dkan10. All rights reserved.
//

import UIKit

class LoginVc: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lbAppName: UILabel!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var btnStartChat: UIButton!
    let deviceModelName = UIDevice.current.modelName
    let iphone4Inch: [String] = [DeviceConstants.MODEL_IPHONE_5,
                                 DeviceConstants.MODEL_IPHONE_5C,
                                 DeviceConstants.MODEL_IPHONE_5S,
                                 DeviceConstants.MODEL_IPHONE_SE]
    
    let iPhone47Inch: [String] = [DeviceConstants.MODEL_IPHONE_6,
                                  DeviceConstants.MODEL_IPHONE_6S,
                                  DeviceConstants.MODEL_IPHONE_7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUserName.delegate = self
        
        // multi language for title
        tfUserName.placeholder = MultiLanguage.tfUserName
        btnStartChat.setTitle(MultiLanguage.btnStartChat, for: .normal)
        
        // addObserver for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnStartChat(_ sender: Any) {
        let userName = tfUserName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.view.endEditing(true)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let chatVc = sb.instantiateViewController(withIdentifier: "ChatVc") as? ChatVc
        chatVc?.userName = userName
        self.present(chatVc!, animated: true) {
            print("present ChatVc successful!")
        }

        
    }
    
    // tap anywhere and close soft keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: TextField delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        textField.textColor = Color.black
        
        switch textField {
        case tfUserName:
            textField.placeholder = MultiLanguage.tfUserName
        default:
            textField.placeholder = ""
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    
    // MARK: Keyboard delegate
    func keyboardDidShow(notification: NSNotification) {
        var yMove = CGFloat(0)
        if iphone4Inch.contains(deviceModelName){
            yMove = -110
        } else if iPhone47Inch.contains(deviceModelName) {
            yMove = -70
        } else if deviceModelName == DeviceConstants.MODEL_IPHONE_SIMULATOR{
            yMove =  -100
        } else {
            yMove = 0
        }
        
        // Assign new frame to your view
        self.view.superview?.backgroundColor = Color.white
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: yMove, width: self.view.frame.width, height: self.view.frame.height)
            self.view.layoutIfNeeded()
        }, completion: { finished in
            print("keyboard opened + LoginVc")
        })
        
    }
    
    func keyboardDidHide(notification: NSNotification) {
        self.view.superview?.backgroundColor = Color.white
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.layoutIfNeeded()
        }, completion: { finished in
            print("keyboard closed + LoginVc")
        })
    }
    
    
}
