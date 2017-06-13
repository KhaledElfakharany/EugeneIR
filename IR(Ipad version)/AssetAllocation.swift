//
//  AssetAllocation.swift
//  IR
//
//  Created by Khaled Elfakharany on 5/30/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit

class AssetAllocation: UIViewController,UITabBarDelegate{
    @IBOutlet weak var remainder: UILabel!
    @IBOutlet weak var remainder2: UILabel!
    @IBOutlet weak var settings: UITabBarItem!
    @IBOutlet weak var IRSystem: UITabBarItem!
    @IBOutlet weak var stockPicks: UITabBarItem!
    
    var remainderValue : Float = 100.0
    let step: Float = 1.0
    
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider1Lbl: UILabel!
    @IBOutlet weak var slider1OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider1OverLeading: NSLayoutConstraint!
    var slider1Prev : Float = 0.0
    
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider2Lbl: UILabel!
    @IBOutlet weak var slider2OverLeading: NSLayoutConstraint!
    @IBOutlet weak var slider2OverTrailing: NSLayoutConstraint!
    var slider2Prev : Float = 0.0
    
    @IBOutlet weak var slider3: UISlider!
    @IBOutlet weak var slider3Lbl: UILabel!
    @IBOutlet weak var slider3OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider3OverLeading: NSLayoutConstraint!
    var slider3Prev : Float = 0.0
    
    @IBOutlet weak var slider4: UISlider!
    @IBOutlet weak var slider4Lbl: UILabel!
    @IBOutlet weak var slider4OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider4OverLeading: NSLayoutConstraint!
    var slider4Prev : Float = 0.0
    
    @IBOutlet weak var slider5: UISlider!
    @IBOutlet weak var slider5Lbl: UILabel!
    @IBOutlet weak var slider5OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider5OverLeading: NSLayoutConstraint!
    var slider5Prev : Float = 0.0
    
    @IBOutlet weak var slider6: UISlider!
    @IBOutlet weak var slider6Lbl: UILabel!
    @IBOutlet weak var slider6OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider6OverLeading: NSLayoutConstraint!
    var slider6Prev : Float = 0.0
    
    @IBOutlet weak var slider7: UISlider!
    @IBOutlet weak var slider7Lbl: UILabel!
    @IBOutlet weak var slider7OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider7OverLeading: NSLayoutConstraint!
    var slider7Prev : Float = 0.0
    
    @IBOutlet weak var slider8: UISlider!
    @IBOutlet weak var slider8Lbl: UILabel!
    @IBOutlet weak var slider8OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider8OverLeading: NSLayoutConstraint!
    var slider8Prev : Float = 0.0
    
    @IBOutlet weak var slider9: UISlider!
    @IBOutlet weak var slider9Lbl: UILabel!
    @IBOutlet weak var slider9OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider9OverLeading: NSLayoutConstraint!
    var slider9Prev : Float = 0.0
    
    @IBOutlet weak var slider10: UISlider!
    @IBOutlet weak var slider10Lbl: UILabel!
    @IBOutlet weak var slider10OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider10OverLeading: NSLayoutConstraint!
    var slider10Prev : Float = 0.0
    
    @IBOutlet weak var slider11: UISlider!
    @IBOutlet weak var slider11Lbl: UILabel!
    @IBOutlet weak var slider11OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider11OverLeading: NSLayoutConstraint!
    var slider11Prev : Float = 0.0
    
    @IBOutlet weak var slider12: UISlider!
    @IBOutlet weak var slider12Lbl: UILabel!
    @IBOutlet weak var slider12OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider12OverLeading: NSLayoutConstraint!
    var slider12Prev : Float = 0.0
    
    @IBOutlet weak var slider13: UISlider!
    @IBOutlet weak var slider13Lbl: UILabel!
    @IBOutlet weak var slider13OverTrailing: NSLayoutConstraint!
    @IBOutlet weak var slider13OverLeading: NSLayoutConstraint!
    var slider13Prev : Float = 0.0
    
    @IBOutlet weak var tabBar: UITabBar!
    var user: User!
    let api = ApiRequests()
    
    var enterAA = Array<Dictionary<String, Any>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        api.getCurrentAsset(from: user, callback: { response in
            self.updateSliders(aa: response)
        })
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == settings {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            vc.user = self.user
            self.present(vc, animated: true, completion: nil)
        }
        else if item == IRSystem{
            let abtus = storyboard?.instantiateViewController(withIdentifier: "AboutUs") as! AboutUs
            abtus.user = self.user
            self.present(abtus, animated: true, completion: nil)
        }
    }
    
    
    func updateSliders(aa: AA){
        slider1.value = Float(aa.id1)
        slider1Prev = Float(aa.id1)
        slider1Lbl.text = "\(aa.id1!)%"
        
        slider2.value = Float(aa.id2!)
        slider2Lbl.text = "\(aa.id2!)%"
        slider2Prev = Float(aa.id2)
        
        slider3.value = Float(aa.id3!)
        slider3Lbl.text = "\(aa.id3!)%"
        slider3Prev = Float(aa.id3)
        
        slider4.value = Float(aa.id4!)
        slider4Lbl.text = "\(aa.id4!)%"
        slider4Prev = Float(aa.id4)
        
        slider5.value = Float(aa.id5!)
        slider5Lbl.text = "\(aa.id5!)%"
        slider5Prev = Float(aa.id5)
        
        slider6.value = Float(aa.id6!)
        slider6Lbl.text = "\(aa.id6!)%"
        slider6Prev = Float(aa.id6)
        
        slider7.value = Float(aa.id7!)
        slider7Lbl.text = "\(aa.id7!)%"
        slider7Prev = Float(aa.id7)
        
        slider8.value = Float(aa.id8!)
        slider8Lbl.text = "\(aa.id8!)%"
        slider8Prev = Float(aa.id8)
        
        slider9.value = Float(aa.id9!)
        slider9Lbl.text = "\(aa.id9!)%"
        slider9Prev = Float(aa.id9)
        
        slider10.value = Float(aa.id10!)
        slider10Lbl.text = "\(aa.id10!)%"
        slider10Prev = Float(aa.id10)
        
        slider11.value = Float(aa.id11!)
        slider11Lbl.text = "\(aa.id11!)%"
        slider11Prev = Float(aa.id11)
        
        slider12.value = Float(aa.id12!)
        slider12Lbl.text = "\(aa.id12!)%"
        slider12Prev = Float(aa.id12)
        
        slider13.value = Float(aa.id13!)
        slider13Lbl.text = "\(aa.id13!)%"
        slider13Prev = Float(aa.id13)
        
        remainderValue -= Float(aa.total)
        remainder.text = "\(Int(remainderValue))%"
        remainder2.text = "\(Int(remainderValue))%"
        
        self.updateLeading()
        self.updateTrailing()
        
        
        
    }
    
    func updateTrailing() {
        slider1OverTrailing.constant = (CGFloat((100 - (remainderValue + slider1.value)) * -2.75))
        slider2OverTrailing.constant = (CGFloat((100 - (remainderValue + slider2.value)) * -2.75))
        slider3OverTrailing.constant = (CGFloat((100 - (remainderValue + slider3.value)) * -2.75))
        slider4OverTrailing.constant = (CGFloat((100 - (remainderValue + slider4.value)) * -2.75))
        slider5OverTrailing.constant = (CGFloat((100 - (remainderValue + slider5.value)) * -2.75))
        slider6OverTrailing.constant = (CGFloat((100 - (remainderValue + slider6.value)) * -2.75))
        slider7OverTrailing.constant = (CGFloat((100 - (remainderValue + slider7.value)) * -2.75))
        slider8OverTrailing.constant = (CGFloat((100 - (remainderValue + slider8.value)) * -2.75))
        slider9OverTrailing.constant = (CGFloat((100 - (remainderValue + slider9.value)) * -2.75))
        slider10OverTrailing.constant = (CGFloat((100 - (remainderValue + slider10.value)) * -2.75))
        slider11OverTrailing.constant = (CGFloat((100 - (remainderValue + slider11.value)) * -2.75))
        slider12OverTrailing.constant = (CGFloat((100 - (remainderValue + slider12.value)) * -2.75))
        slider13OverTrailing.constant = (CGFloat((100 - (remainderValue + slider13.value)) * -2.75))
    }
    
    func updateLeading() {
        slider1OverLeading.constant = 26 + (CGFloat(slider1.value * 2.75))
        slider2OverLeading.constant = 26 + (CGFloat(slider2.value * 2.75))
        slider3OverLeading.constant = 26 + (CGFloat(slider3.value * 2.75))
        slider4OverLeading.constant = 26 + (CGFloat(slider4.value * 2.75))
        slider5OverLeading.constant = 26 + (CGFloat(slider5.value * 2.75))
        slider6OverLeading.constant = 26 + (CGFloat(slider6.value * 2.75))
        slider7OverLeading.constant = 26 + (CGFloat(slider7.value * 2.75))
        slider8OverLeading.constant = 26 + (CGFloat(slider8.value * 2.75))
        slider9OverLeading.constant = 26 + (CGFloat(slider9.value * 2.75))
        slider10OverLeading.constant = 26 + (CGFloat(slider10.value * 2.75))
        slider11OverLeading.constant = 26 + (CGFloat(slider11.value * 2.75))
        slider12OverLeading.constant = 26 + (CGFloat(slider12.value * 2.75))
        slider13OverLeading.constant = 26 + (CGFloat(slider13.value * 2.75))
        
    }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        if sender == slider1 {
            if slider1.value > slider1Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider1.value - slider1Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider1Lbl.text = "\(Int(roundedValue))%"
                    slider1Prev = slider1.value
                    updateLeading()
                    updateTrailing()
                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider1.value = slider1Prev
                }
            }
            if slider1.value < slider1Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider1Prev - slider1.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider1Lbl.text = "\(Int(roundedValue))%"
                slider1Prev = slider1.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider2 {
            if slider2.value > slider2Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider2.value - slider2Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider2Lbl.text = "\(Int(roundedValue))%"
                    slider2Prev = slider2.value
                    updateLeading()
                    updateTrailing()
                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider2.value = slider2Prev
                }
            }
            if slider2.value < slider2Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider2Prev - slider2.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider2Lbl.text = "\(Int(roundedValue))%"
                slider2Prev = slider2.value
                updateLeading()
                updateTrailing()
            }
        }
        if sender == slider3 {
            if slider3.value > slider3Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider3.value - slider3Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider3Lbl.text = "\(Int(roundedValue))%"
                    slider3Prev = slider3.value
                    updateLeading()
                    updateTrailing()
                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider3.value = slider3Prev
                }
            }
            if slider3.value < slider3Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider3Prev - slider3.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider3Lbl.text = "\(Int(roundedValue))%"
                slider3Prev = slider3.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider4 {
            if slider4.value > slider4Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider4.value - slider4Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider4Lbl.text = "\(Int(roundedValue))%"
                    slider4Prev = slider4.value
                    updateLeading()
                    updateTrailing()
                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider4.value = slider4Prev
                }
            }
            if slider4.value < slider4Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider4Prev - slider4.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider4Lbl.text = "\(Int(roundedValue))%"
                slider4Prev = slider4.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider5 {
            if slider5.value > slider5Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider5.value - slider5Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider5Lbl.text = "\(Int(roundedValue))%"
                    slider5Prev = slider5.value
                    updateLeading()
                    updateTrailing()
                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider5.value = slider5Prev
                }
            }
            if slider5.value < slider5Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider5Prev - slider5.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider5Lbl.text = "\(Int(roundedValue))%"
                slider5Prev = slider5.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider6 {
            if slider6.value > slider6Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider6.value - slider6Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider6Lbl.text = "\(Int(roundedValue))%"
                    slider6Prev = slider6.value
                    updateLeading()
                    updateTrailing()                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider6.value = slider6Prev
                }
            }
            if slider6.value < slider6Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider6Prev - slider6.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider6Lbl.text = "\(Int(roundedValue))%"
                slider6Prev = slider6.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider7 {
            if slider7.value > slider7Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider7.value - slider7Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider7Lbl.text = "\(Int(roundedValue))%"
                    slider7Prev = slider7.value
                    updateLeading()
                    updateTrailing()                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider7.value = slider7Prev
                }
            }
            if slider7.value < slider7Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider7Prev - slider7.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider7Lbl.text = "\(Int(roundedValue))%"
                slider7Prev = slider7.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider8 {
            if slider8.value > slider8Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider8.value - slider8Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider8Lbl.text = "\(Int(roundedValue))%"
                    slider8Prev = slider8.value
                    updateLeading()
                    updateTrailing()
                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider8.value = slider8Prev
                }
            }
            if slider8.value < slider8Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider8Prev - slider8.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider8Lbl.text = "\(Int(roundedValue))%"
                slider8Prev = slider8.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider9 {
            if slider9.value > slider9Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider9.value - slider9Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider9Lbl.text = "\(Int(roundedValue))%"
                    slider9Prev = slider9.value
                    updateLeading()
                    updateTrailing()
                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider9.value = slider9Prev
                }
            }
            if slider9.value < slider9Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider9Prev - slider9.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider9Lbl.text = "\(Int(roundedValue))%"
                slider9Prev = slider9.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider10 {
            if slider10.value > slider10Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider10.value - slider10Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider10Lbl.text = "\(Int(roundedValue))%"
                    slider10Prev = slider10.value
                    updateLeading()
                    updateTrailing()
                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider10.value = slider10Prev
                }
            }
            if slider10.value < slider10Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider10Prev - slider10.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider10Lbl.text = "\(Int(roundedValue))%"
                slider10Prev = slider10.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider11 {
            if slider11.value > slider11Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider11.value - slider11Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider11Lbl.text = "\(Int(roundedValue))%"
                    slider11Prev = slider11.value
                    updateLeading()
                    updateTrailing()                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider11.value = slider11Prev
                }
            }
            if slider11.value < slider11Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider11Prev - slider11.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider11Lbl.text = "\(Int(roundedValue))%"
                slider11Prev = slider11.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider12 {
            if slider12.value > slider12Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider12.value - slider12Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider12Lbl.text = "\(Int(roundedValue))%"
                    slider12Prev = slider12.value
                    updateLeading()
                    updateTrailing()                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider12.value = slider12Prev
                }
            }
            if slider12.value < slider12Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider12Prev - slider12.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider12Lbl.text = "\(Int(roundedValue))%"
                slider12Prev = slider12.value
                updateLeading()
                updateTrailing()
                
            }
        }
        if sender == slider13 {
            if slider13.value > slider13Prev {
                if remainderValue > 0 {
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    remainderValue = remainderValue - (slider13.value - slider13Prev)
                    remainder.text = "\(Int(remainderValue))%"
                    remainder2.text = "\(Int(remainderValue))%"
                    slider13Lbl.text = "\(Int(roundedValue))%"
                    slider13Prev = slider13.value
                    updateLeading()
                    updateTrailing()                }else{
                    let roundedValue = round(sender.value / step) * step
                    sender.value = roundedValue
                    slider13.value = slider13Prev
                }
            }
            if slider13.value < slider13Prev{
                let roundedValue = round(sender.value / step) * step
                sender.value = roundedValue
                remainderValue = remainderValue + (slider13Prev - slider13.value)
                remainder.text = "\(Int(remainderValue))%"
                remainder2.text = "\(Int(remainderValue))%"
                slider13Lbl.text = "\(Int(roundedValue))%"
                slider13Prev = slider13.value
                updateLeading()
                updateTrailing()
                
            }
        }
        
        
        
    }
    @IBAction func resetPressed(_ sender: Any) {
        slider1.value = 0.0
        slider1Prev = 0.0
        slider1Lbl.text = "\(0.0)%"
        
        slider2.value = 0.0
        slider2Lbl.text = "\(0.0)%"
        slider2Prev = 0.0
        
        slider3.value = 0.0
        slider3Lbl.text = "\(0.0)%"
        slider3Prev = 0.0
        
        slider4.value = 0.0
        slider4Lbl.text = "\(0.0)%"
        slider4Prev = 0.0
        
        slider5.value = 0.0
        slider5Lbl.text = "\(0.0)%"
        slider5Prev = 0.0
        
        slider6.value = 0.0
        slider6Lbl.text = "\(0.0)%"
        slider6Prev = 0.0
        
        slider7.value = 0.0
        slider7Lbl.text = "\(0.0)%"
        slider7Prev = 0.0
        
        slider8.value = 0.0
        slider8Lbl.text = "\(0.0)%"
        slider8Prev = 0.0
        
        slider9.value = 0.0
        slider9Lbl.text = "\(0.0)%"
        slider9Prev = 0.0
        
        slider10.value = 0.0
        slider10Lbl.text = "\(0.0)%"
        slider10Prev = 0.0
        
        slider11.value = 0.0
        slider11Lbl.text = "\(0.0)%"
        slider11Prev = 0.0
        
        slider12.value = 0.0
        slider12Lbl.text = "\(0.0)%"
        slider12Prev = 0.0
        
        slider13.value = 0.0
        slider13Lbl.text = "\(0.0)%"
        slider13Prev = 0.0
        
        remainderValue = 100.0
        remainder.text = "\(Int(remainderValue))%"
        remainder2.text = "\(Int(remainderValue))%"
        
        self.updateLeading()
        self.updateTrailing()
        
    }
    @IBAction func goPressed(_ sender: Any) {
        let total = slider1.value+slider2.value+slider3.value+slider4.value+slider5.value+slider6.value+slider7.value+slider8.value+slider9.value+slider10.value+slider11.value+slider12.value+slider13.value
        if total < 100 {
            showAlert(title: "Error", message: "Please Fill the 100%")
//            self.api.recommendationRequest(user: self.user, completed: { (status,message,recommendation) in
//                print(status)
//            })
        }else {
            let dict1 = ["id":1,"percentage":Int(slider1.value)]
            self.enterAA.append(dict1)
            let dict2 = ["id":2,"percentage":Int(slider2.value)]
            self.enterAA.append(dict2)
            let dict3 = ["id":3,"percentage":Int(slider3.value)]
            self.enterAA.append(dict3)
            let dict4 = ["id":4,"percentage":Int(slider4.value)]
            self.enterAA.append(dict4)
            let dict5 = ["id":5,"percentage":Int(slider5.value)]
            self.enterAA.append(dict5)
            let dict6 = ["id":6,"percentage":Int(slider6.value)]
            self.enterAA.append(dict6)
            let dict7 = ["id":7,"percentage":Int(slider7.value)]
            self.enterAA.append(dict7)
            let dict8 = ["id":8,"percentage":Int(slider8.value)]
            self.enterAA.append(dict8)
            let dict9 = ["id":9,"percentage":Int(slider9.value)]
            self.enterAA.append(dict9)
            let dict10 = ["id":10,"percentage":Int(slider10.value)]
            self.enterAA.append(dict10)
            let dict11 = ["id":11,"percentage":Int(slider11.value)]
            self.enterAA.append(dict11)
            let dict12 = ["id":12,"percentage":Int(slider12.value)]
            self.enterAA.append(dict12)
            let dict13 = ["id":13,"percentage":Int(slider13.value)]
            self.enterAA.append(dict13)
            
            do {
                
                //Convert to Data
                let jsonData = try JSONSerialization.data(withJSONObject: enterAA, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                //Convert back to string. Usually only do this for debugging
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print("JSON String:\(JSONString)")
                    
                    self.api.enterAA(user: self.user, data: JSONString, completed: { (status,message) in
                        if status == "ok" {
                            self.showAlert(title: "Success", message: message)
                        } else {
                            self.showAlert(title: "Error", message: message)
                        }
                    })
                }
                
            } catch {
                print(error)
            }
            
            
        }
    }
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if title == "Success"{
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecommendationVC") as! RecommendationVC
                vc.user = self.user
                self.present(vc, animated: true, completion: nil)
            }))
        }else{
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}
