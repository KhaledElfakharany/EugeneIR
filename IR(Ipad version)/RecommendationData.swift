//
//  RecommendationData.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/4/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import Foundation

class RecommendationData {
    var outputArraySearch = [[RecommendationItem]]()
    var outputArrayData = [RecommendationSection]()
    
    
    init(array: [Dictionary<String,Any>]) {
        for item in array {
            let sectionItem = RecommendationSection(dict: item)
            outputArrayData.append(sectionItem)
            let subsections = item["subsections"]  as! [Dictionary<String,Any>]
            var itemsArray = [RecommendationItem]()
            for section in subsections {
                let subSectionName = section["name_en"] as! String
                let sectionID = section["id"] as! Int
                let sets = section["set"] as! [Dictionary<String,Any>]
                for set in sets {
                    let outputItem = RecommendationItem()
                    let setName = set["name"] as! String
                    let setId = set["id"] as! Int
                    outputItem.subSectionId = sectionID
                    outputItem.setId = setId
                    outputItem.nameEn = setName
                    outputItem.subSectionName = subSectionName
                    outputItem.maxTotal = sectionItem.maxTotal
                    outputItem.freeText = sectionItem.allowFreeText
                    outputItem.sectionId = sectionItem.sectionID
                    itemsArray.append(outputItem)
                }
            }
            outputArraySearch.append(itemsArray)
        }
    }
}
