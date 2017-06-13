//
//  SettingsVC.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/2/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController,UITabBarDelegate {
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet weak var numberOfRecommendations: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var ratingStars: UIImageView!
    @IBOutlet weak var settingsItem: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var IRSystems: UITabBarItem!
    @IBOutlet weak var stockPicks: UITabBarItem!
    
    var user: User!
    
    let ratings = ["Free User", "Premium", "Professional", "Top Picks"]
    
    
    let api = ApiRequests()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        tabBar.selectedItem = settingsItem
        mailLbl.text = user.email
        self.api.login(with: user, callback: { (authData,error) in
            self.numberOfRecommendations.text = "\(String(describing: authData!.metadata!.recommendations))"
            self.ratingLbl.text = self.ratings[(authData?.metadata?.rating)!-1]
            self.ratingStars.image = UIImage(named: String(describing: authData!.metadata!.rating))
        })
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == IRSystems {
            let abtus = storyboard?.instantiateViewController(withIdentifier: "AboutUs") as! AboutUs
            abtus.user = self.user
            self.present(abtus, animated: true, completion: nil)
        }else if item == stockPicks{
            self.api.login(with: user, callback: { (authData,errorMessage) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Picks") as! Picks
                vc.user = self.user
                if (authData?.metadata?.app_premium)! {
                    vc.accountType = "premium"
                }else {
                    vc.accountType = "regular"
                }
                vc.risk = authData?.metadata?.risikoneigung
                self.present(vc, animated: true, completion: nil)
            })
        }
    }

    

@IBAction func PWDPressed(_ sender: Any) {
    showAlert(title: "Change Password", message: "Enter the new password")
}

func showAlertPass(title: String, message: String){
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

func showAlert(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addTextField(configurationHandler: { (passwordTextField) in
        passwordTextField.placeholder = "Enter New Password"
        
    })
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
        
        if let password = alert.textFields?[0].text{
            if password.characters.count > 0 {
                self.api.settingsRequest(user: self.user, newPassword: password, completed: { (status,message) in
                    if status == "ok" {
                        self.showAlertPass(title: "Success", message: message)
                    } else {
                        self.showAlertPass(title: "Error", message: message)
                    }
                })
            }
        }
    }))
    self.present(alert, animated: true, completion: nil)
}
}
