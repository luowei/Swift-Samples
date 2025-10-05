//
//  LWPickerLabel.swift
//  LWPickerLabel
//
//  Created by luowei on 16/8/5.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit


class LWPickerLabel: UILabel {
    
    lazy var _inputView: LWAreaPickerView? = {
        guard let inputV = LWAreaPickerView.loadFromNibNamed("LWAreaPickerView") as? LWAreaPickerView as LWAreaPickerView? else{return nil}
        inputV.responder = self
        return inputV
    }()
    
    // MARK: - Override
    
    override var inputView: UIView? {
        get { return _inputView }
//        set {
//            guard let v = newValue as? LWAreaPickerView as LWAreaPickerView? else{ return }
//            _inputView = v
//        }
    }
    
    override func awakeFromNib() {
        self.userInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(LWPickerLabel.tapSelf(_:)))
        gesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(gesture)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return self.enabled
    }
    
    override func resignFirstResponder() -> Bool {
        return super.resignFirstResponder()
    }
    
    func tapSelf(sender: AnyObject) {
        self.becomeFirstResponder()
    }
    
}


class LWAreaPickerView: UIView {
//    @IBOutlet weak var dataSource: UIPickerViewDataSource?
//    @IBOutlet weak var delegate: UIPickerViewDelegate?
    
    @IBOutlet weak var topNavView: UIView!
    @IBOutlet weak var pickView: UIPickerView!
    
    weak var responder: UIResponder?
    
    var addressService: LWAddressService?
    var provinceData:[LWAddress]?
    var cityData:[LWAddress]?
    var areaData:[LWAddress]?
    var townData:[LWAddress]?
    
    var selProvinceRow:Int = 0
    var selCityRow:Int = 0
    var selAreaRow:Int = 0
    var selTownRow:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let service = try? LWAddressService.open()  as LWAddressService? else{ return }
        addressService = service
    }
    
    @IBAction func close(){
        responder?.resignFirstResponder()
    }
}




//MARK: - UIPickerViewDataSource 实现
extension LWAreaPickerView: UIPickerViewDataSource{
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch component {
        case 0:
            provinceData = addressService?.provinceList()
            if let provinces = provinceData {
                count = provinces.count
            }
            print("province:\(provinceData?.count)")
        case 1:
            guard let provinceRow = selProvinceRow as Int? else{break}
            //let provinceRow = self.pickView.selectedRowInComponent(component - 1)
            guard let provinces = provinceData where provinces.count > 0 else{break}
            guard let provinceId = provinces[provinceRow].ownId as String? else{break}
            cityData = addressService?.cityList(provinceId)
            if let cities = cityData {
                count = cities.count
            }
        case 2:
            guard let cityRow = selCityRow as Int? else{break}
            //let cityRow = self.pickView.selectedRowInComponent(component - 1)
            guard let cities = cityData where cities.count > 0 else{break}
            guard let cityId = cities[cityRow].ownId as String? else{break}
            areaData = addressService?.areaList(cityId)
            if let areas = areaData {
                count = areas.count
            }
        case 3:
            guard let areaRow = selAreaRow as Int? else{break}
            //let areaRow = self.pickView.selectedRowInComponent(component - 1)
            print("========areaRow:\(areaRow) areaData:\(areaData)")
            guard let areas = areaData where areas.count > 0 else{break}
            guard let areaId = areas[areaRow].ownId as String? else{break}
            townData = addressService?.townList(areaId)
            if let towns = townData {
                count = towns.count
            }
            print("town:\(townData?.count)")
        default:break
        }

        return count
    }
    
    
}

//MARK: - UIPickerViewDelegate 实现
extension LWAreaPickerView: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.bounds.width / 4
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        guard let data = pickerData as [LWAddress]? else{ return nil}
//        
//        return data[row].name
//    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.delegate?.pickerLabel(self, didSelectRow: row, inComponent: component)
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let rowView: UIView
        if let view = view {
            rowView = view
        }else{
            guard let rowV = LWPickerRow.loadFromNibNamed("LWPickerRow") as? LWPickerRow as LWPickerRow? else{return UIView()}
            switch component {
            case 0:
                provinceData = addressService?.provinceList()
                if let provinces = provinceData  where provinces.count > 0  {
                    //rowV.backgroundColor = UIColor.lightGrayColor()
                    rowV.textLabel.text = provinces[row].name
                    rowV.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(rowV.textLabel.frame)
                }else{
                    return UIView()
                }
            case 1:
                let provinceRow = self.pickView.selectedRowInComponent(component - 1)
                guard let provinces = provinceData where provinces.count > 0 else{return UIView()}
                guard let provinceId = provinces[provinceRow].ownId as String? else{return UIView()}
                cityData = addressService?.cityList(provinceId)
                if let cities = cityData where cities.count > 0 {
                    //rowV.backgroundColor = UIColor.brownColor()
                    rowV.textLabel.text = cities[row].name
                    rowV.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(rowV.textLabel.frame)
                }else{
                    return UIView()
                }
            case 2:
                let cityRow = self.pickView.selectedRowInComponent(component - 1)
                guard let cities = cityData where cities.count > 0 else{return UIView()}
                guard let cityId = cities[cityRow].ownId as String? else{return UIView()}
                areaData = addressService?.areaList(cityId)
                if let areas = areaData where areas.count > 0  {
                    //rowV.backgroundColor = UIColor.greenColor()
                    rowV.textLabel.text = areas[row].name
                    rowV.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(rowV.textLabel.frame)
                }else{
                    return UIView()
                }
            case 3:
                let areaRow = self.pickView.selectedRowInComponent(component - 1)
                guard let areas = areaData where areas.count > 0 else{return UIView()}
                guard let areaId = areas[areaRow].ownId as String? else{return UIView()}
                townData = addressService?.townList(areaId)
                if let towns = townData where towns.count > 0  {
                    //rowV.backgroundColor = UIColor.blueColor()
                    rowV.textLabel.text = towns[row].name
                    rowV.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(rowV.textLabel.frame)
                }else{
                    return UIView()
                }
            default:break
            }
            rowView = rowV
        }
        return rowView
    }
}


//MARK: LWPickerRow 实现

class LWPickerRow: UIView {
    @IBOutlet weak var textLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}