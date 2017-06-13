//
//  RegisterVC.swift
//  IR
//
//  Created by Khaled Elfakharany on 5/30/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit
import DropDown

class RegisterVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var investmentHorizonField: UITextField!
    @IBOutlet weak var riskField: UITextField!
    
    var dropDownForRiskField = UIPickerView()
    var dropDownForInvestmentField = UIPickerView()
    
    @IBOutlet weak var pleaseLabel: UILabel!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var riskclassLabel: UILabel!
    @IBOutlet weak var investmentHorizon: UILabel!
    
    @IBOutlet weak var alreadyHaveButton: UIButton!
    
    let dropDown = DropDown()
    let riskCategoryArray = ["Risk-tolerant", "Tendency towards risk-tolerant", "Balanced", "Tendency towards risk-averse", "Risk-averse"]
    let investmentCategoryArray = ["No investment horizon", "short-term", "mid-term", "long-term"]
    
    var riskArray = ["Risk-tolerant",
                     "Tendency towards risk-tolerant",
                     "Balanced",
                     "Tendency towards risk-averse",
                     "Risk-averse"]
    var investmentHorizonArray = ["No investment horizon",
                                  "short-term",
                                  "mid-term",
                                  "long-term"]
    var requestDict = ["Risk-tolerant":"1",
                       "Tendency towards risk-tolerant":"2",
                       "Balanced":"3",
                       "Tendency towards risk-averse":"4",
                       "Risk-averse":"5",
                       "No investment horizon":"0",
                       "short-term":"1",
                       "mid-term":"2",
                       "long-term":"3"]
    let api = ApiRequests()
    
    //MARK: - ViewController Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        riskField.delegate = self
        investmentHorizonField.delegate = self
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    //MARK: - Button Actions
    
    @IBAction func pressHaveAccountButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func goPressed(_ sender: Any) {
        if isFieldEmpty(){
            self.showAlert(title: "Error", message: "Fill all the fields")
        }else{
            let user = User(withEmail: emailField.text!, andPassword: passwordField.text!)
            self.api.register(user: user, risikoneigung: requestDict[riskField.text!]!, anlagehorizont: requestDict[investmentHorizonField.text!]!, completed:{ (status,message) in
                if status == "ok"{
                    print(message)
                    self.showAlert(title: "Success", message: message)
                }else {
                    print(message)
                    self.showAlert(title: "Error", message: message)
                }
            })
        }
    }
    
    //MARK: - Keyboard Notification Receive
    
//    func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height/3
//            }
//        }
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0{
//                self.view.frame.origin.y += keyboardSize.height/3
//            }
//        }
//    }
    
    
    //MARK: - Text Field Methods
    
    func isFieldEmpty() -> Bool {
        if (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! || (riskField.text?.isEmpty)! || (investmentHorizonField.text?.isEmpty)! {
            return true
        } else {
            return false
        }
    }
    
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin editing")
        if textField == riskField{
            setupDropDown(textField: riskField, Array: riskCategoryArray)
//            textField.endEditing(true)÷
            dropDown.show()
        }
        else if textField == investmentHorizonField {
            setupDropDown(textField: investmentHorizonField, Array: investmentCategoryArray)
//            textField.endEditing(true)
            dropDown.show()
        }
    }
    
    func setupDropDown(textField: UITextField, Array: [String]) {
        dropDown.anchorView = textField
        dropDown.topOffset = CGPoint(x: 0, y: -180)
        dropDown.bottomOffset = CGPoint(x: 0, y: textField.bounds.height)
        dropDown.dataSource = Array
        dropDown.selectionAction = { (index, item) in
            textField.text = item
    }
}

//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == riskField {
//            self.presentAlert(withPicker: &dropDownForRiskField)
//            view.endEditing(true)
//            textField.endEditing(true)
//        }
//        if textField == investmentHorizonField {
//            self.presentAlert(withPicker: &dropDownForInvestmentField)
//            textField.endEditing(true)
//        }
//    }
    
    //MARK: - Alert Action Seet
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if title == "Success"{
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        }else{
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
//    
//    func presentAlert(withPicker pickerView: inout UIPickerView) {
//        
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        
//        let currentView = alert.view.subviews[0]
//        currentView.translatesAutoresizingMaskIntoConstraints = false
//        
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        currentView.addSubview(pickerView)
//        
//        pickerView.centerXAnchor.constraint(equalTo: currentView.centerXAnchor).isActive = true
//        pickerView.topAnchor.constraint(equalTo: currentView.topAnchor, constant: -16).isActive = true
//        currentView.heightAnchor.constraint(equalTo: pickerView.heightAnchor, constant: 16).isActive = true
//        
//        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
    
    //MARK: - UIPickerViewDataSource
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
//        if pickerView == dropDownForRiskField {
//            return riskArray.count
//        }
//        if pickerView == dropDownForInvestmentField {
//            return investmentHorizonArray.count
//        }
//        return 0
//    }
    
    //MARK: - UIPickerViewDelegate
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == dropDownForRiskField {
//            self.view.endEditing(true)
//            return riskArray[row]
//        }
//        if pickerView == dropDownForInvestmentField {
//            self.view.endEditing(true)
//            return investmentHorizonArray[row]
//        }
//        return nil
//    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == dropDownForRiskField {
//            riskField.text = riskArray[row]
//        }
//        if pickerView == dropDownForInvestmentField {
//            investmentHorizonField.text = investmentHorizonArray[row]
//        }
//    }
//    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
