//
//  SubsectionCell.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/4/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class SubsectionCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(label: String){
        label1.text = label
    }
}
