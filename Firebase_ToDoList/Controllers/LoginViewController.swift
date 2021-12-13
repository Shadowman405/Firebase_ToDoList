//
//  ViewController.swift
//  Firebase_ToDoList
//
//  Created by Maxim Mitin on 12.12.21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    private let segueID = "tasksSegue"
    
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warningLbl.alpha = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        Auth.auth().addStateDidChangeListener {[weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueID)!, sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTxtFld.text = ""
        passwordTxtFld.text = ""
    }
    
    func displayWarningLabel(with text: String) {
        warningLbl.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut]) {
            self.warningLbl.alpha = 1
        } completion: { complete in
            self.warningLbl.alpha = 0
        }

    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        guard let email = emailTxtFld.text,
              let password = passwordTxtFld.text,
              email.isEmpty == false,
              password.isEmpty == false else {
            displayWarningLabel(with: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error != nil {
                self?.displayWarningLabel(with: "Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            }
            
            self?.displayWarningLabel(with: "No such user")
        }
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        guard let email = emailTxtFld.text,
              let password = passwordTxtFld.text,
              email.isEmpty == false,
              password.isEmpty == false else {
            displayWarningLabel(with: "Info is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {user, error in
            if error == nil {
                if user != nil {
                } else {
                    print("User is not created")
                }
            } else {
                print(error?.localizedDescription)
            }
        }
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
