//
//  Picks.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/5/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class Picks: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var isin: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var picks: UITabBarItem!
    @IBOutlet weak var IRSystems: UITabBarItem!
    @IBOutlet weak var settings: UITabBarItem!
    @IBOutlet weak var riskType: UIImageView!
    
    var user: User!
    var accountType: String!
    var itemUrl: String!
    let api = ApiRequests()
    var otherPicks = [PickItem]()
    var sortedPicks = [PickItem]()
    var risk : Int!
    let months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        tabBar.delegate = self
        tabBar.selectedItem = picks
        
        api.picks(user: user,risk: risk, completed: { (status,message,data,month,year) in
            self.date.text = "\(self.months[month-1]) \(year)"
            self.symbol.text = data.myPick.symbol
            self.isin.text = data.myPick.isin
            self.itemUrl = data.myPick.url
            self.otherPicks = data.otherPicks
            self.riskType.image = UIImage(named: "risk\(data.myPick.risk!)")
            for x in 1...self.otherPicks.count+1 {
                for item in self.otherPicks {
                    if item.risk == x {
                        self.sortedPicks.append(item)
                    }
                }
            }
            self.table.reloadData()
        })
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == settings {
            let abtus = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            abtus.user = self.user
            self.present(abtus, animated: true, completion: nil)
        }else if item == IRSystems{
            let abtus = storyboard?.instantiateViewController(withIdentifier: "AboutUs") as! AboutUs
            abtus.user = self.user
            self.present(abtus, animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if accountType == "premium" {
            return otherPicks.count
        }else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "PickCell", for: indexPath) as? PickCell {
            if accountType == "premium" {
                cell.configCell(item: sortedPicks[indexPath.row])
            }else{
                cell.configCell2()
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.view.frame.width < 415{
        if accountType == "premium" {
            return 100
        }else {
            return 300
        }
        }
        else{
            if accountType == "premium" {
                return 170
            }else {
                return 300
            }
        }
    }
    
    @IBAction func infoPressed(_ sender: Any) {
        let url = URL(string: itemUrl)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
