//
//  RecomendationSection.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/4/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import Foundation

class RecommendationSection {
    var sectionID : Int!
    var required : Int!
    var allowFreeText : Bool!
    var maxTotal : Int!
    var nameEn: String!
    var nameDe : String!
    var percentage: Int!
    
    init(dict : Dictionary<String,Any>) {
        sectionID = dict["id"] as! Int
        required = dict["required"] as! Int
        allowFreeText = dict["allow_freetext"] as! Bool
        maxTotal = dict["max_total"] as! Int
        nameEn = dict["name_en"] as! String
        nameDe = dict["name_de"] as! String
        percentage = dict["percentage"] as! Int
    }
}
