//
//  RecommendationVC.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/2/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class RecommendationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    let api = ApiRequests()
    var inputArrayData = [RecommendationSection]()
    var inputArraySearch = [[RecommendationItem]]()
    var recomendationsJSON = [Dictionary<String,Any>]()
    var user : User!
    //    = User(withEmail: "fakharany.developer@gmail.com", andPassword: "khaled")
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
//        user = User(withEmail: "k.fakharany@nu.edu.eg", andPassword: "sosaqwe")
        api.recommendationRequest(user: user, completed: { (status,message,recommendation) in
            self.inputArrayData = recommendation.outputArrayData
            self.inputArraySearch = recommendation.outputArraySearch
            print(recommendation.outputArrayData[0].nameEn)
            self.table.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputArrayData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "AssetsCell", for: indexPath) as? AssetsCell {
            cell.configCell(data: inputArrayData[indexPath.row],inputArraySearch: self.inputArraySearch[indexPath.row],table: tableView,index: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func goPressed(_ sender: Any) {
        for item in globalSelectedItems {
            let dict = ["freetext":item.freeText,"section_id":item.sectionId,"subsection_id":item.subSectionId,"recommendation_id":item.setId] as [String : Any]
            self.recomendationsJSON.append(dict)
        }
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: recomendationsJSON, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print("JSON String:\(JSONString)")
                api.enterRecommendation(user: user, data: JSONString, submit: 0, completed: { (status,message,submit) in
                    print(message)
                    print(status)
                    if submit == "Can Be Submitted" {
                        self.showAlert(title: "Success", message: submit,data: JSONString)
                    }
                    else {
                        self.showAlert(title: "Error", message: submit,data: JSONString)
                    }
                })
            }
            
        } catch {
            print(error)
        }
        recomendationsJSON.removeAll()
    }
    func showAlert(title: String, message: String, data : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if title == "Success"{
            alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { action in
                self.api.enterRecommendation(user: self.user, data: data, submit: 1, completed: { (status,message,submit) in
                    print("Submited: \(message)")
                    self.showAlert2(title: "Submit", message: message)
                    if status == "ok" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Picks") as! Picks
                        vc.user = self.user
                        self.present(vc, animated: true, completion: nil)
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
                self.api.saveRecommendation(user: self.user, completed: { (status,message) in
                    print("Saved : \(status)")
                    self.showAlert2(title: "Save", message: message)
                })
            }))
        }else{
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert2(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.view.frame.width < 500 {
            if indexPath.row == cellIndex {
                return (CGFloat(120+(numberOfItemsInTable*45)))
            }
            return 120
        }else {
            if indexPath.row == cellIndex {
                return (CGFloat(200+(numberOfItemsInTable*60)))
            }
            return 200
        }
    }
    @IBAction func backPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AssetAllocation") as! AssetAllocation
        vc.user = user
        self.present(vc, animated: true, completion: nil)
    }
}
