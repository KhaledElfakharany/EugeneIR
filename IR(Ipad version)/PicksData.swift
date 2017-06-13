//
//  PicksData.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/5/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import Foundation

class PicksData {
    var myPick = PickItem()
    var otherPicks = [PickItem]()
    
    init(array: [Dictionary<String,Any>], currentRisk: Int){
        for item in array {
            print("item: \(item)\n")
            if let url = item["url"] as? String {
                if let isin = item["isin"] as? String {
                    if let symbol = item["symbol"] as? String {
                        if  let risk = item["risk"] as? Int {
                            if risk == currentRisk {
                                myPick.url = url
                                myPick.isin = isin
                                myPick.symbol = symbol
                                myPick.risk = risk
                            }else {
                                let pickItem = PickItem()
                                pickItem.url = url
                                pickItem.isin = isin
                                pickItem.symbol = symbol
                                pickItem.risk = risk
                                otherPicks.append(pickItem)
                            }
                        }
                    }
                }
            }
            
            
            
            
        }
    }
}
