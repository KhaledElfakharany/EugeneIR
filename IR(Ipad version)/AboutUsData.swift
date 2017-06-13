//
//  AboutUsData.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/3/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import Foundation

class AboutUsData {
    
    var link1 : String!
    var link2 : String!
    var subHeader : String!
    var text : String!
    var videoURL : String!
    var pictureURL : String!
    
    
    init(dict : Dictionary<String,Any>){
        link1 = dict["link1"] as! String
        link2 = dict["link2"] as! String
        subHeader = dict["subheader"] as! String
        subHeader = subHeader.replacingOccurrences(of: "Performances ", with: "")
        text = dict["text"] as! String
        videoURL = dict["video"] as! String
        pictureURL = dict["picture"] as! String
    }
    
}
