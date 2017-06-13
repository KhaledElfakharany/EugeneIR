//
//  aboutUs.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/2/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import AlamofireImage

class AboutUs: UIViewController,UITabBarDelegate {
    
    @IBOutlet weak var aboutUsText: UILabel!
    @IBOutlet weak var periodTime: UILabel!
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var stockPicks: UITabBarItem!
    @IBOutlet weak var IRSystem: UITabBarItem!
    @IBOutlet weak var youSettings: UITabBarItem!
    
    
    var user : User!
    let api = ApiRequests()
    var webLink1 : String!
    var webLink2 : String!
    var videoLink : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        tabBar.selectedItem = IRSystem
        api.aboutUsRequest(user: user, language: "en", completed: { (status,message,data) in
            self.aboutUsText.text = data.text.html2String
            self.periodTime.text = data.subHeader
            self.webLink1 = data.link1!
            self.webLink2 = data.link2!
            self.videoLink = data.videoURL!
            let url = URL(string: data.pictureURL!)
            self.graphImage.af_setImage(withURL: url!)
            
            print("videoURL: \(self.videoLink)")
            print("link1: \(self.webLink2)")
            print("link2: \(self.webLink2)")
        })
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == youSettings {
            let abtus = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
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
    
    func chooseLink(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Link1", style: .default, handler: { error in
            let url = URL(string: self.webLink1)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Link2", style: .default, handler: { error in
            let url = URL(string: self.webLink2)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func webPressed(_ sender: Any) {
        chooseLink(title: "Choose Link", message: "")
    }
    @IBAction func videoPressed(_ sender: Any) {
        if var videoURL2 = videoLink {
            videoURL2 = videoURL2.replacingOccurrences(of: "webm", with: "mp4")
            let videoURL = URL(string: videoURL2)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
}
extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print(error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
