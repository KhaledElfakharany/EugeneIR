//
//  sliderCell.swift
//  IR(Ipad version)
//
//  Created by Khaled Elfakharany on 6/14/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class sliderCell: UITableViewCell {
    
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var trailingConst: NSLayoutConstraint!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var slider: CustomUISlider!
    @IBOutlet weak var percentage: UILabel!
    
    var sliderPrev : Float!
    var globalLabel : UILabel!
    let step: Float = 1.0
    var index : Int!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCell(input: AA,label : UILabel, index: Int){
        name.text = input.name!
        slider.value = Float(input.percentage!)
        sliderPrev = slider.value
        percentage.text = "\(Int(slider.value))%"
        globalLabel = label
        globalLabel.text = "\(globalRemaining)%"
        self.index = index
        updateLeading()
        updateTrailing()
    }
    func updateTrailing() {
        trailingConst.constant = (CGFloat((100 - (globalRemaining + Int(slider.value)))) * 5.75) + 62
    }
    func updateLeading() {
        leadingConst.constant = 26 + (CGFloat(slider.value * 5.7))
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        if slider.value > sliderPrev {
            if globalRemaining > 0 {
                let roundedValue = round(slider.value / step) * step
                slider.value = roundedValue
                globalRemaining = globalRemaining - Int(slider.value - sliderPrev)
                globalLabel.text = "\(Int(globalRemaining))%"
                percentage.text = "\(Int(roundedValue))%"
                sliderPrev = slider.value
                
            }else{
                let roundedValue = round(slider.value / step) * step
                slider.value = roundedValue
                slider.value = sliderPrev
            }
        }
        if slider.value < sliderPrev {
            let roundedValue = round(slider.value / step) * step
            slider.value = roundedValue
            globalRemaining = globalRemaining + Int(sliderPrev - slider.value)
            globalLabel.text = "\(Int(globalRemaining))%"
            percentage.text = "\(Int(roundedValue))%"
            sliderPrev = slider.value
            
        }
        updateLeading()
        updateTrailing()
        inputArray[index].percentage = Int(slider.value)
        globalTable.reloadData()
    }
}
