//
//  AssetsCell.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/4/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import UIKit
import DropDown
var globalSelectedItems = [RecommendationItem]()
var cellIndex = 0
var numberOfItemsInTable = 0

class AssetsCell: UITableViewCell, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var percentLbl: UILabel!
    @IBOutlet weak var inputSearch: UISearchBar!
    @IBOutlet weak var subsectionsTable: UITableView!
    @IBOutlet weak var selectedCounterLbl: UILabel!
    
    var selectedItems = [String]()
    var inputArray = [String]()
    var dropDownArray = [String]()
    var rawData = [RecommendationItem]()
    var rawDataCopy = [RecommendationItem]()
    var semiGlobalItems = [RecommendationItem]()
    var cellIndexLocal: Int!
    
    var fatherTable = UITableView()
    
    let dropDown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subsectionsTable.delegate = self
        subsectionsTable.dataSource = self
        inputSearch.delegate = self
        setupDropDown()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if inputSearch.text == nil || inputSearch.text == "" {

        } else {
            dropDown.show()
            let name = inputSearch.text
            dropDownArray = inputArray.filter({$0.localizedCaseInsensitiveContains(name!)})
            dropDown.dataSource = dropDownArray

        }
    }
    
    func configCell(data: RecommendationSection,inputArraySearch: [RecommendationItem], table: UITableView,index: Int) {
        fatherTable = table
        cellIndexLocal = index
        label.text = data.nameEn
        percentLbl.text = "\(data.percentage!)%"
        rawData = inputArraySearch
        rawDataCopy = rawData
        for item in rawData {
            let dropDownString = "\(item.nameEn!)-\(item.subSectionName!)-\(item.setId!)"
            inputArray.append(dropDownString)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = subsectionsTable.dequeueReusableCell(withIdentifier: "SubsectionCell", for: indexPath) as? SubsectionCell {
            cell.configCell(label: selectedItems[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        numberOfItemsInTable = self.selectedItems.count
        cellIndex = self.cellIndexLocal
        fatherTable.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputArray.append(selectedItems[indexPath.row])
        if rawDataCopy.count != rawData.count {
            inputArray.removeAll()
            for item in rawData {
                if item.subSectionName == semiGlobalItems[indexPath.row].subSectionName {
                    rawDataCopy.append(item)
                    print("rag3na \(item.subSectionName)")
                }
            }
            for showItem in self.rawDataCopy {
                let dropDownString = "\(showItem.nameEn!)-\(showItem.subSectionName!)-\(showItem.setId!)"
                self.inputArray.append(dropDownString)
            }
            for selectedItem in selectedItems {
                if inputArray.contains(selectedItem){
                    self.inputArray.remove(at: self.inputArray.index(of: selectedItem)!)
                }
            }
            inputArray.append(selectedItems[indexPath.row])
        }
        semiGlobalItems.remove(at: indexPath.row)
        globalSelectedItems = semiGlobalItems
        selectedItems.remove(at: indexPath.row)
        subsectionsTable.deleteRows(at: [indexPath], with: .fade)
        selectedCounterLbl.text = "You have entered \(self.selectedItems.count) recommendations"
        if selectedItems.count == 0 {
            selectedCounterLbl.textColor = UIColor.red
        }
        numberOfItemsInTable = self.selectedItems.count
        cellIndex = self.cellIndexLocal
        fatherTable.reloadData()
    }
    
    func setupDropDown() {
        dropDown.anchorView = inputSearch
        dropDown.topOffset = CGPoint(x: 0, y: -180)
        dropDown.bottomOffset = CGPoint(x: 0, y: inputSearch.bounds.height)
        dropDown.dataSource = dropDownArray
        dropDown.selectionAction = { (index, item) in
            if self.rawData[0].maxTotal > self.selectedItems.count {
                for DataItem in self.rawData {
                    if "\(DataItem.nameEn!)-\(DataItem.subSectionName!)-\(DataItem.setId!)" == item {
                        
                        var repeatedItem = 1
                        for checkItem in self.semiGlobalItems {
                            if checkItem.subSectionName == DataItem.subSectionName {
                                repeatedItem += 1
                            }
                        }
                        if repeatedItem < 3  {
                            globalSelectedItems.append(DataItem)
                            self.semiGlobalItems.append(DataItem)
                            self.inputSearch.text = ""
                            self.inputArray.remove(at: self.inputArray.index(of: item)!)
                            self.selectedItems.append(item)
                            self.selectedCounterLbl.text = "You have entered \(self.selectedItems.count) recommendations"
                            self.selectedCounterLbl.textColor = UIColor.init(rgb: 0x58A72F)
                            self.subsectionsTable.reloadData()
                            numberOfItemsInTable = self.selectedItems.count
                            cellIndex = self.cellIndexLocal
                            self.fatherTable.reloadData()
                            
                        }else if repeatedItem == 3 {
                            globalSelectedItems.append(DataItem)
                            self.semiGlobalItems.append(DataItem)
                            self.inputSearch.text = ""
                            self.inputArray.remove(at: self.inputArray.index(of: item)!)
                            self.selectedItems.append(item)
                            self.selectedCounterLbl.text = "You have entered \(self.selectedItems.count) recommendations"
                            self.selectedCounterLbl.textColor = UIColor.init(rgb: 0x58A72F)
                            numberOfItemsInTable = self.selectedItems.count
                            cellIndex = self.cellIndexLocal
                            self.subsectionsTable.reloadData()
                            self.fatherTable.reloadData()
                            
                            print("da5lna fe el else")
                            self.inputArray.removeAll()
                            var index = 0
                            for item in self.rawDataCopy {
                                print("index : \(index) , count: \(self.rawDataCopy.count)")
                                if index >= self.rawDataCopy.count {
                                    print("A7aaaaaa")
                                    index = 0
                                }
                                if item.subSectionName == DataItem.subSectionName {
                                    print("3amlna remove l \(self.rawDataCopy[index].subSectionName)")
                                    self.rawDataCopy.remove(at: index )
                                    index-=1
                                }
                                
                                index+=1
                            }
                            for showItem in self.rawDataCopy {
                                let dropDownString = "\(showItem.nameEn!)-\(showItem.subSectionName!)-\(showItem.setId!)"
                                self.inputArray.append(dropDownString)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
