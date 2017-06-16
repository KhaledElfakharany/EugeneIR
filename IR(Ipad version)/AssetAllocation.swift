//
//  AssetAllocation.swift
//  IR(Ipad version)
//
//  Created by Khaled Elfakharany on 6/13/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

var globalRemaining = 100
var globalTable: UITableView!
var inputArray = [AA]()

class AssetAllocation: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var remainingAssets: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var user : User!
    let api = ApiRequests()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User(withEmail: "k.fakharany@nu.edu.eg", andPassword: "sosaqwe")
        table.delegate = self
        table.dataSource = self
        globalTable = table
        api.getCurrentAsset(from: user, callback: { (inputAA,remaining) in
            inputArray = inputAA
            globalRemaining = remaining
            self.table.reloadData()
        })
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "sliderCell", for: indexPath) as? sliderCell {
            cell.configureCell(input: inputArray[indexPath.row],label: remainingAssets,index: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        for item in inputArray {
            item.percentage = 0
        }
        globalRemaining = 100
        globalTable.reloadData()
    }
    
    @IBAction func goPressed(_ sender: Any) {
        var enterAA = [Dictionary<String,Int>]()
        for item in inputArray {
            let dict = ["id":item.id,"percentage":item.percentage]
            enterAA.append(dict as! [String : Int])
        }
        do {
            
            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: enterAA, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print("JSON String:\(JSONString)")
                
                self.api.enterAA(user: self.user, data: JSONString, completed: { (status,message) in
                    if status == "ok" {
                        self.showAlert(title: "Success", message: message)
                    } else {
                        self.showAlert(title: "Error", message: message)
                    }
                })
            }
            
        } catch {
            print(error)
        }
    }
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if title == "Success"{
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecommendationVC") as! RecommendationVC
                vc.user = self.user
                self.present(vc, animated: true, completion: nil)
            }))
        }else{
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }


}
