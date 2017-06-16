//
//  AAData.swift
//  IR(Ipad version)
//
//  Created by Khaled Elfakharany on 6/13/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import Foundation

class AAData {
    var AAArray = [AA]()
    var remaining = 100
    
    init(array : [Dictionary<String,Any>]) {
        for item in array {
            let AAItem = AA()
            AAItem.name = item["name_en"] as! String
            AAItem.percentage = item["percentage"] as! Int
            AAItem.id = item["id"] as! Int
            AAArray.append(AAItem)
            remaining-=AAItem.percentage
        }
    }
}
