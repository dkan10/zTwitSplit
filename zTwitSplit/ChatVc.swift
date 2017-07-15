//
//  ChatVc.swift
//  zTwitSplit
//
//  Created by dkan10 on 7/15/17.
//  Copyright © 2017 dkan10. All rights reserved.
//

import UIKit

class ChatVc: UIViewController {
    
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    @IBOutlet weak var lbUserName: UILabel!
    var userName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if userName != nil {
            lbUserName.text = userName
        }
        
        // Status bar white font
        self.navigationController?.navigationBar.barTintColor = Color.black
        self.navigationController?.navigationBar.tintColor = Color.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogout(_ sender: Any) {
      self.dismiss(animated: true) { 
        
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
