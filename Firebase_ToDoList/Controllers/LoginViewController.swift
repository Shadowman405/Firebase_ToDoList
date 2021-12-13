//
//  ViewController.swift
//  Firebase_ToDoList
//
//  Created by Maxim Mitin on 12.12.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    @IBAction func loginClicked(_ sender: UIButton) {
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
    }
    
}


//MARK: - Keyboard adaptation for small devices

extension LoginViewController {
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView) .contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
        (self.view as! UIScrollView) .contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
}
