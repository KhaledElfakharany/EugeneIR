//
//  AA.swift
//  IR
//
//  Created by Khaled Elfakharany on 5/31/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import Foundation

class AA {
    var id1 : Int!
    var id2 : Int!
    var id3 : Int!
    var id4 : Int!
    var id5 : Int!
    var id6 : Int!
    var id7 : Int!
    var id8 : Int!
    var id9 : Int!
    var id10 : Int!
    var id11 : Int!
    var id12 : Int!
    var id13 : Int!
    var total : Int!
    
    init(array: [Dictionary<String,Any>]) {
        for item in array {
            if item["id"] as! Int == 1 {
                id1 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 2 {
                id2 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 3 {
                id3 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 4 {
                id4 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 5 {
                id5 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 6 {
                id6 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 7 {
                id7 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 8 {
                id8 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 9 {
                id9 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 10 {
                id10 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 11 {
                id11 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 12 {
                id12 = item["percentage"] as! Int
            }
            if item["id"] as! Int == 13 {
                id13 = item["percentage"] as! Int
            }
        }
        total = id1!+id2!+id3!+id4!+id5!+id6!+id7!+id8!+id9!+id10!+id11!+id12!+id13!
        
    }
}
