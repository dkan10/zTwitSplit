//
//  ChatVc.swift
//  zTwitSplit
//
//  Created by dkan10 on 7/15/17.
//  Copyright © 2017 dkan10. All rights reserved.
//

import UIKit

class ChatVc: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tbvMessage: UITableView!
    @IBOutlet weak var viewNewMessageContainer: UIView!
    @IBOutlet weak var tvCurrentMessage: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    // MARK: Constraint
    @IBOutlet weak var hViewNewMessageContainer: NSLayoutConstraint!
    var hViewHeight: CGFloat = 0.0
    var userName:String?
    
    var messages = [Message]()
    let testMessage = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32. Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32. Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32."
    
    let testMessage2 = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvCurrentMessage.text = MultiLanguage.sendMessagePlaceHolder
        tvCurrentMessage.textColor = Color.lightGray
        tvCurrentMessage.delegate = self
        
        // Status bar white font
        self.navigationController?.navigationBar.barTintColor = Color.mainColor
        self.navigationController?.navigationBar.tintColor = Color.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVc.keyboardWillShow(_:)), name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVc.keyboardWillChange(_:)), name:.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVc.keyboardWillHide(_:)), name:.UIKeyboardWillHide, object: nil)
        
        tbvMessage.estimatedRowHeight = 80
        tbvMessage.rowHeight = UITableViewAutomaticDimension
        tbvMessage.tableFooterView = UIView()
        btnSend.isEnabled = false
        hViewHeight = hViewNewMessageContainer.constant
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tvCurrentMessage.isScrollEnabled = false
    }
    
    
    // MARK: IBAction
    @IBAction func btnSend(_ sender: AnyObject) {
        btnSend.isEnabled = false
        self.view.endEditing(true)
        let message = tvCurrentMessage.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if message == MultiLanguage.sendMessagePlaceHolder  || message == "" {
            let message = MultiLanguage.sendMessageEmptyContent
            FuncUtils.shared.showAlert(vc: self, message: message)
        } else { // send message here.
            // message is less than or equal to 50 characters, post it as is.
            if message.characters.count <= 50 {
                let post = Message(sender: userName!, time: FuncUtils.shared.getCurrentDate(), content: message)
                messages.append(post)
                self.tbvMessage.reloadData()
            } else {
                // if there is any word which length is over 50, return error
                let messageArrSpitBySpace = message.components(separatedBy: " ")
                for message in messageArrSpitBySpace {
                    if ((message as NSString).length > 50) {
                        let message = MultiLanguage.sendMessageMustContainSpace
                        FuncUtils.shared.showAlert(vc: self, message: message)
                        return
                    }
                }
                // split message before update in UI.
                let messageArr = FuncUtils.shared.splitMessage(message: message as NSString)
                let time = FuncUtils.shared.getCurrentDate()
                for i in 0..<messageArr.count {
                    let post = Message(sender: userName!, time: time, content: messageArr[i])
                    messages.append(post)
                }
                self.tbvMessage.reloadData()
            }
            
        }
        
        FuncUtils.shared.tableViewScrollToBottom(animated: true, tableView: tbvMessage)
        tvCurrentMessage.text = MultiLanguage.sendMessagePlaceHolder
        tvCurrentMessage.textColor = Color.lightGray
        tvCurrentMessage.setNeedsLayout()
        tvCurrentMessage.layoutIfNeeded()
        hViewNewMessageContainer.constant = hViewHeight
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true) {
            // back to LoginVc.
            print("logout successful")
        }
    }
    
    // MARK: TextView delegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text.characters.count + text.characters.count - range.length
        if (newLength > 1000) {
            return false
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if self.tvCurrentMessage.isScrollEnabled == false {
            self.tvCurrentMessage.isScrollEnabled = true
        }
        if textView.text == "" || textView.text == MultiLanguage.sendMessagePlaceHolder {
            btnSend.isEnabled = false
        } else {
            btnSend.isEnabled = true
        }
        let numberOfLine =  Int(textView.contentSize.height/(textView.font?.lineHeight)!)
        hViewNewMessageContainer.constant = numberOfLine > 5 ? 16 + (textView.font?.lineHeight)!*5 :  16 + textView.contentSize.height
        tvCurrentMessage.setNeedsLayout()
        tvCurrentMessage.layoutIfNeeded()
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        tvCurrentMessage.textColor = UIColor.black
        if (tvCurrentMessage.text == MultiLanguage.sendMessagePlaceHolder) {
            tvCurrentMessage.text = ""
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (tvCurrentMessage.text == "") {
            tvCurrentMessage.text = MultiLanguage.sendMessagePlaceHolder
            tvCurrentMessage.textColor = UIColor.lightGray
        }
    }
    
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = tbvMessage.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        let message = self.messages[indexPath.row]
        
        cell.lbSender.text = message.sender
        cell.lbTime.text = message.time
        cell.tvContent.text = message.content
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    // MARK: Keyboard delegate
    func keyboardWillShow(_ sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.view.frame.origin.y == 0) {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillChange(_ sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    func keyboardWillHide(_ sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
}
