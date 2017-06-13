//
//  PickCell.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/5/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class PickCell: UITableViewCell {

    @IBOutlet weak var sybmbol: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var isin: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var riskType: UIImageView!
    
    var url: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(item: PickItem){
        sybmbol.text = item.symbol
        isin.text = item.isin
        url = item.url
//        riskType.image = UIImage(named: "risk\(item.risk!)")
        
    }
    
    func configCell2(){
        pic.image = UIImage(named: "purchase")
        sybmbol.isHidden = true
        isin.isHidden = true
        btn.isHidden = true
//        riskType.isHidden = true
    }

    @IBAction func infoPressed(_ sender: Any) {
        let url = URL(string: self.url)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
