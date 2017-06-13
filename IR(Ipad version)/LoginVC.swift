//
//  LoginVC.swift
//  IR
//
//  Created by Khaled Elfakharany on 5/30/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var pleaseLbl: UILabel!
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    
    @IBOutlet weak var forgotBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let api = ApiRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height/2
            }
        }
    }
    
    func isFieldEmpty() -> Bool {
        if (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            return true
        } else {
            return false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func goPressed(_ sender: Any) {
        if isFieldEmpty() {
            self.showAlert(title: "Error", message: "Please enter email and password")
        }else {
            let user = User(withEmail: emailField.text!, andPassword: passwordField.text!)
            self.api.login(with: user, callback: { (authData,errorMessage) in
                if errorMessage != nil {
                    print("Error: \(errorMessage!)")
                    self.showAlert(title: "Invalid", message: "Check Email and Password")
                } else {
                    if authData?.metadata?.show_screen == "aa"{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AssetAllocation") as! AssetAllocation
//                        vc.user = user
                        self.present(vc, animated: true, completion: nil)
                    }else if authData?.metadata?.show_screen == "recommendations" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecommendationVC") as! RecommendationVC
                        vc.user = user
                        self.present(vc, animated: true, completion: nil)
                    }else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Picks") as! Picks
                        vc.user = user
                        if (authData?.metadata?.app_premium)! {
                            vc.accountType = "premium"
                        }else {
                            vc.accountType = "regular"
                        }
                        vc.risk = authData?.metadata?.risikoneigung
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    @IBAction func registerPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if title == "Invalid" || title == "Eroor" {
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        }
        else {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func resetPasswordPressed(_ sender: Any) {
        self.showForgotAllert()
    }
    func showForgotAllert() {
        let forgotAlert = UIAlertController(title: "Forgot?", message: "Do tou want to request new password?", preferredStyle: .alert)
        forgotAlert.addTextField { (emailTextField: UITextField) in
            emailTextField.placeholder = "Email"
        }
        forgotAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        forgotAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action :UIAlertAction) in
            if let emailText = forgotAlert.textFields?[0].text {
                self.api.forgotPassword(for: emailText, callback: { (status:String, message:String, url: String?) in
                    self.showAlert(title: status, message: message)
                })
            }
        }))
        self.present(forgotAlert, animated: true, completion: nil)
    }
    
}
