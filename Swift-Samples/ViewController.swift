//
//  ViewController.swift
//  Swift-Samples
//
//  Created by luowei on 15/11/3.
//  Copyright © 2015年 wodedata. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var titleLbl: UILabel?
    var progressVal: UILabel?

    var customVal: UITextField?
    var btn: UIButton?

    var progress: UIProgressView?
    var slide: UISlider?
    
    //KVO
    var text:String = ""{
        willSet(newText) {
            print("About to set totalSteps to \(newText)")
        }
        didSet {
            self.textChanged(text)
        }
    }

    //当接收到spotlight传来的activity
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.isHidden = true
        self.tabBarController!.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.isHidden = false
        self.tabBarController!.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let selfFrame = self.view.frame
        let selfCenter = self.view.center;

        //状态标题
        titleLbl = UILabel(frame: CGRect(x: selfCenter.x - 150, y: 30, width: 300, height: 60))
        titleLbl?.backgroundColor = UIColor.green
        titleLbl?.textAlignment = .center
        titleLbl?.text = "Hello"
        self.view.addSubview(titleLbl!)

        //进度数值
        progressVal = UILabel(frame: CGRect(x: selfCenter.x - 40, y: 120, width: 80, height: 60))
        progressVal?.text = "0";
        self.view.addSubview(progressVal!)

        //自定义数值设置框
        customVal = UITextField(frame: CGRect(x: selfCenter.x - 65, y: 200, width: 60, height: 40))
        customVal?.backgroundColor = UIColor.lightGray
        customVal?.textAlignment = .center
        customVal?.delegate = self
        self.view.addSubview(customVal!)

        //设置按钮
        btn = UIButton(frame: CGRect(x: selfCenter.x + 5, y: 200, width: 60, height: 40))
        btn?.backgroundColor = UIColor.gray
        btn?.layer.cornerRadius = 10
        btn!.setTitle("设置", for: UIControlState())
        btn!.addTarget(self, action: #selector(ViewController.setupSlideVal(_:)), for: .touchUpInside)
        self.view.addSubview(btn!)

        //进度条
        progress = UIProgressView(progressViewStyle: .default)
        progress!.frame = CGRect(x: 20, y: 300, width: selfFrame.size.width - 40, height: 2)
        self.view.addSubview(progress!)

        //滑杆
        slide = UISlider(frame: CGRect(x: 20, y: 400, width: selfFrame.size.width - 40, height: 30))
        slide!.minimumValue = 0
        slide!.maximumValue = 120
        slide!.value = 0
        self.view.addSubview(slide!);

        slide!.addTarget(self, action: #selector(ViewController.slideChanged(_:)), for: .valueChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textChanged(_ text:String) {
//        UIAlertView(title: "Text改变了", message: "Text改变成了\(text)", delegate: nil, cancelButtonTitle: "OK").show()
        
        let alertController = UIAlertController(title: "Text改变了", message: "Text改变成了\(text)", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }

    //当输入框完成编辑
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        self.textFieldDidChanged(textField)
        return true
    }
    func textFieldDidChanged(_ textField: UITextField) {
        if (textField.isEqual(customVal)) {
            progressVal!.text = textField.text!.isEmpty ? progressVal?.text:textField.text;
            slide!.value = Float((customVal?.text)!)!
            slide?.sendAction(#selector(ViewController.slideChanged(_:)), to: self, for: nil)
        }
    }


    //手动设置滑杆值
    func setupSlideVal(_ btn: UIButton) {
        slide!.value = Float((customVal?.text)!)!
        slide?.sendAction(#selector(ViewController.slideChanged(_:)), to: self, for: nil)
        
        self.text = String(slide!.value)
    }

    //当滑杆值发生变化
    func slideChanged(_ slide: UISlider) {
        progress?.progress = slide.value / 120
        progressVal?.text = String(slide.value)
        

        let slideVal = CompareExpression.number(slide.value);

        //小于40,表示进度条在上传范围内
        let val40 = CompareExpression.number(40);
        let uploadResult = compare(CompareExpression.compare(slideVal, val40))
        switch Int(uploadResult) {
                //小于40
        case CompareResult.Less.rawValue:
            //原型值的使用
            self.titleLbl?.text = Status.Uploading.rawValue

                //等于40
        case CompareResult.Equal.rawValue:
            self.titleLbl?.text = Status.Uploaded.rawValue



                //大于40 , 解压
        case CompareResult.Great.rawValue:
            //大于40,小于80,表示进度条在上传范围内
            let val80 = CompareExpression.number(80);

            let extractResult = compare(CompareExpression.compare(slideVal, val80))
            switch Int(extractResult) {
                    //小于80
            case CompareResult.Less.rawValue:
                //原型值的使用
                self.titleLbl?.text = Status.Extracting.rawValue

                    //等于80
            case CompareResult.Equal.rawValue:
                self.titleLbl?.text = Status.Extracted.rawValue



                    //大于80 , 读取
            case CompareResult.Great.rawValue:
                //大于80,小于100,表示在读取范围内
                let val100 = CompareExpression.number(100);

                let readResult = compare(CompareExpression.compare(slideVal, val100))
                switch Int(readResult) {
                        //小于100
                case CompareResult.Less.rawValue:
                    //原型值的使用
                    self.titleLbl?.text = Status.Reading.rawValue

                        //等于100
                case CompareResult.Equal.rawValue:
                    self.titleLbl?.text = Status.Readed.rawValue

                        //大于100
                case CompareResult.Great.rawValue:
                    let text = Flag.read("已经读取完毕,正在执行数据操作...")
                    self.titleLbl?.text = String(describing: text)

                default:break
                }

            default:break
            }

        default:break
        }

    }


}


//相关值

enum Flag {

    //上传
    case upload(String)
    //解压
    case extract(String)
    //读取
    case read(String)

    //成功或失败
    case isOK(Int)
}



//原始值(默认值)

enum Status: String {

    case Uploading = "正在上传"
    case Uploaded = "上传完毕"

    case Extracting = "正在解压"
    case Extracted = "解压完毕"

    case Reading = "正在读取"
    case Readed = "读取完毕"
}



//递归枚举

enum CompareExpression {
    case number(Float)
    indirect case compare(CompareExpression, CompareExpression)
}

func compare(_ expression: CompareExpression) -> Float {

    switch expression {
            //直接返回相关值
    case .number(let value):
        return value

            //比较大小
    case .compare(let left, let right):
        if compare(left) > compare(right) {
            return 1
        } else if compare(left) < compare(right) {
            return -1
        } else {
            return 0
        }

    }
}



//结构体的使用

struct CompareResult: OptionSet {
    let rawValue: Int
    init(rawValue: Int) {
        self.rawValue = rawValue
    }

    static let Less = CompareResult(rawValue: -1)
    static let Equal = CompareResult(rawValue: 0)
    static let Great = CompareResult(rawValue: 1)

    static let LessOrEqual: CompareResult = [Less, Equal]
    static let GreatOrEqual: CompareResult = [Great, Equal]

}

