//
//  LWAddressLabel.swift
//  LWAddressLabel
//
//  Created by luowei on 16/8/6.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit

class LWAddressLabel: UILabel {
    var provinceId:String = "0"
    var cityId:String = "0"
    var areaId:String = "0"
    var townId:String = "0"

    lazy var _inputView: LWAddressPickerView? = {
        guard let inputV = LWAddressPickerView.loadFromNibNamed("LWAddressPickerView") as? LWAddressPickerView as LWAddressPickerView? else{return nil}
        inputV.responder = self
        return inputV
    }()
    
    // MARK: - Override
    
    override var inputView: UIView? {
        get { return _inputView }
//        set {
//            guard let v = newValue as? LWAddressPickerView as LWAddressPickerView? else{ return }
//            _inputView = v
//        }
    }
    
    override func awakeFromNib() {
        self.userInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(LWAddressLabel.tapSelf(_:)))
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
    
    func setAddress(province provinceId:String,province:String,cityId:String,city:String,areaId:String,area:String,townId:String,town:String){
        self.provinceId = provinceId
        self.cityId = cityId
        self.areaId = areaId
        self.townId = townId
        self.text = province + city + area + town
    }

}


enum AddrFiled {
    case Province(String?)
    case City(String?)
    case Area(String?)
    case Town(String?)
}

class LWAddressPickerView: UIView {
    @IBOutlet weak var provinceBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var areaBtn: UIButton!
    @IBOutlet weak var townBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    @IBOutlet weak var pickView: UITableView!
    
    weak var responder: UIResponder?
    
    var addressService: LWAddressService?
    var provinceData:[LWAddress]?
    var cityData:[LWAddress]?
    var areaData:[LWAddress]?
    var townData:[LWAddress]?
    
    var selProvince:String = "0"
    var selCity:String = "0"
    var selArea:String = "0"
    var selTown:String = "0"
    
    var showFiled:AddrFiled = .Province("0")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearBtn.touchAreaEdgeInsets = UIEdgeInsetsMake(-5, -5, -5, -5)
        
        self.pickView.registerClass(LWAddressTableViewCell.self, forCellReuseIdentifier: "cell")
        self.pickView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        self.pickView.tableFooterView = UIView(frame: CGRect.zero)
        
        guard let service = try? LWAddressService.open()  as LWAddressService? else{ return }
        addressService = service
    }

    @IBAction func ok(){
        guard let label = responder as? LWAddressLabel as LWAddressLabel? else{return}
        guard let province = provinceBtn.titleLabel?.text as String? where province != "请选择" && province != "" else{return}
        guard let city = cityBtn.titleLabel?.text as String? where city != "请选择" && city != "" else{return}
        guard let area = areaBtn.titleLabel?.text as String? where area != "请选择" && area != "" else{return}
        
        guard let town = townBtn.titleLabel?.text as String? where townBtn.selected && town != "请选择" && town != "" else{
            label.setAddress(province:selProvince, province: province, cityId: selCity, city: city, areaId: selArea, area: area, townId: selTown, town: "")
            responder?.resignFirstResponder()
            return
        }
        label.setAddress(province:selProvince, province: province, cityId: selCity, city: city, areaId: selArea, area: area, townId: selTown, town: town)
        responder?.resignFirstResponder()
        
        
    }

    @IBAction func close(){
        responder?.resignFirstResponder()
    }

    @IBAction func clearBtnStatus(){
        provinceBtn.selected = false;
        cityBtn.selected = false;
        areaBtn.selected = false;
        townBtn.selected = false;
        provinceBtn.setTitle("请选择", forState: .Normal)
        cityBtn.setTitle("请选择", forState: .Normal)
        areaBtn.setTitle("请选择", forState: .Normal)
        townBtn.setTitle("请选择", forState: .Normal)
        selProvince = "0"
        selCity = "0"
        selArea = "0"
        selTown = "0"
        showFiled = .Province(nil)
        self.pickView.reloadData()
        self.pickView.setContentOffset(CGPoint(x:0,y:0), animated: false)
    }

    @IBAction func provinceBtnClick(){
        cityBtn.selected = false;
        areaBtn.selected = false;
        townBtn.selected = false;
        cityBtn.setTitle("请选择", forState: .Normal)
        areaBtn.setTitle("请选择", forState: .Normal)
        townBtn.setTitle("请选择", forState: .Normal)
        selCity = "0"
        selArea = "0"
        selTown = "0"
        showFiled = .Province(nil)
        self.pickView.reloadData()
    }

    @IBAction func cityBtnClick(){
        if !provinceBtn.selected {
            return
        }
        areaBtn.selected = false;
        townBtn.selected = false;
        areaBtn.setTitle("请选择", forState: .Normal)
        townBtn.setTitle("请选择", forState: .Normal)
        selArea = "0"
        selTown = "0"
        showFiled = .City(selProvince)
        self.pickView.reloadData()
    }

    @IBAction func areaBtnClick(){
        if !cityBtn.selected {
            return
        }
        townBtn.selected = false;
        townBtn.setTitle("请选择", forState: .Normal)
        selTown = "0"
        showFiled = .Area(selCity)
        self.pickView.reloadData()
    }

    @IBAction func townBtnClick(){
        if !areaBtn.selected {
            return
        }
        showFiled = .Town(selArea)
        self.pickView.reloadData()
    }
}

extension LWAddressPickerView: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var count = 0
        switch showFiled {
        case .Province( _):
            provinceData = addressService?.provinceList()
            guard let data = provinceData as [LWAddress]? else { return 0 }
            count = data.count
        case .City( _):
            cityData = addressService?.cityList(selProvince)
            guard let data = cityData as [LWAddress]? else { return 0 }
            count = data.count
        case .Area(_):
            areaData = addressService?.areaList(selCity)
            guard let data = areaData as [LWAddress]? else { return 0 }
            count = data.count
        case .Town(_):
            townData = addressService?.townList(selArea)
            guard let data = townData as [LWAddress]? else { return 0 }
            return data.count
        }
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? LWAddressTableViewCell as LWAddressTableViewCell? else{ return UITableViewCell() }
         cell.accessoryType = .None
        switch showFiled {
        case .Province(_):
            guard let data = provinceData as [LWAddress]? else { return UITableViewCell() }
            cell.textLabel?.text = data[indexPath.row].name
            if(data[indexPath.row].ownId == selProvince){
                cell.accessoryType = .Checkmark
            }
        case .City(_):
            guard let data = cityData as [LWAddress]? else { return UITableViewCell() }
            cell.textLabel?.text = data[indexPath.row].name
            if(data[indexPath.row].ownId == selCity){
                cell.accessoryType = .Checkmark
            }
        case .Area(_):
            guard let data = areaData as [LWAddress]? else { return UITableViewCell() }
            cell.textLabel?.text = data[indexPath.row].name
            if(data[indexPath.row].ownId == selArea){
                cell.accessoryType = .Checkmark
            }
        case .Town(_):
            guard let data = townData as [LWAddress]? else { return UITableViewCell() }
            cell.textLabel?.text = data[indexPath.row].name
            if(data[indexPath.row].ownId == selTown){
                cell.accessoryType = .Checkmark
            }
        }
        return cell
    }
}


extension LWAddressPickerView:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
//        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? LWAddressTableViewCell as LWAddressTableViewCell? else{return}
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        switch showFiled {
        case .Province(_):
            guard let data = provinceData as [LWAddress]? else {return}
            selProvince = data[indexPath.row].ownId
            provinceBtn.setTitle(data[indexPath.row].name, forState: .Normal)
            provinceBtn.selected = true
            showFiled = .City(selProvince)
        case .City(_):
            guard let data = cityData as [LWAddress]? else {return}
            selCity = data[indexPath.row].ownId
            cityBtn.setTitle(data[indexPath.row].name, forState: .Normal)
            cityBtn.selected = true
            showFiled = .Area(selCity)
        case .Area(_):
            guard let data = areaData as [LWAddress]? else {return}
            selArea = data[indexPath.row].ownId
            areaBtn.setTitle(data[indexPath.row].name, forState: .Normal)
            areaBtn.selected = true
            showFiled = .Town(selArea)
        case .Town(_):
            guard let data = townData as [LWAddress]? else {return}
            selTown = data[indexPath.row].ownId
            townBtn.setTitle(data[indexPath.row].name, forState: .Normal)
            townBtn.selected = true
            showFiled = .Town(data[indexPath.row].superId)
        }
        tableView.reloadData()
    }
    
}

class LWAddressTableViewCell : UITableViewCell{
    var selId = "0"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont.systemFontOfSize(14)
        self.textLabel?.textColor = UIColor(red: 0.21, green: 0.21, blue: 0.21, alpha: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

