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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.hidden = true
        self.tabBarController!.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.hidden = false
        self.tabBarController!.tabBar.hidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let selfFrame = self.view.frame
        let selfCenter = self.view.center;

        //状态标题
        titleLbl = UILabel(frame: CGRectMake(selfCenter.x - 150, 30, 300, 60))
        titleLbl?.backgroundColor = UIColor.greenColor()
        titleLbl?.textAlignment = .Center
        titleLbl?.text = "Hello"
        self.view.addSubview(titleLbl!)

        //进度数值
        progressVal = UILabel(frame: CGRectMake(selfCenter.x - 40, 120, 80, 60))
        progressVal?.text = "0";
        self.view.addSubview(progressVal!)

        //自定义数值设置框
        customVal = UITextField(frame: CGRectMake(selfCenter.x - 65, 200, 60, 40))
        customVal?.backgroundColor = UIColor.lightGrayColor()
        customVal?.textAlignment = .Center
        customVal?.delegate = self
        self.view.addSubview(customVal!)

        //设置按钮
        btn = UIButton(frame: CGRectMake(selfCenter.x + 5, 200, 60, 40))
        btn?.backgroundColor = UIColor.grayColor()
        btn?.layer.cornerRadius = 10
        btn!.setTitle("设置", forState: .Normal)
        btn!.addTarget(self, action: "setupSlideVal:", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn!)

        //进度条
        progress = UIProgressView(progressViewStyle: .Default)
        progress!.frame = CGRectMake(20, 300, selfFrame.size.width - 40, 2)
        self.view.addSubview(progress!)

        //滑杆
        slide = UISlider(frame: CGRectMake(20, 400, selfFrame.size.width - 40, 30))
        slide!.minimumValue = 0
        slide!.maximumValue = 120
        slide!.value = 0
        self.view.addSubview(slide!);

        slide!.addTarget(self, action: "slideChanged:", forControlEvents: .ValueChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textChanged(text:String) {
//        UIAlertView(title: "Text改变了", message: "Text改变成了\(text)", delegate: nil, cancelButtonTitle: "OK").show()
        
        let alertController = UIAlertController(title: "Text改变了", message: "Text改变成了\(text)", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    //当输入框完成编辑
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        self.textFieldDidChanged(textField)
        return true
    }
    func textFieldDidChanged(textField: UITextField) {
        if (textField.isEqual(customVal)) {
            progressVal!.text = textField.text!.isEmpty ? progressVal?.text:textField.text;
            slide!.value = Float((customVal?.text)!)!
            slide?.sendAction("slideChanged:", to: self, forEvent: nil)
        }
    }


    //手动设置滑杆值
    func setupSlideVal(btn: UIButton) {
        slide!.value = Float((customVal?.text)!)!
        slide?.sendAction("slideChanged:", to: self, forEvent: nil)
        
        self.text = String(slide!.value)
    }

    //当滑杆值发生变化
    func slideChanged(slide: UISlider) {
        progress?.progress = slide.value / 120
        progressVal?.text = String(slide.value)
        

        let slideVal = CompareExpression.Number(slide.value);

        //小于40,表示进度条在上传范围内
        let val40 = CompareExpression.Number(40);
        let uploadResult = compare(CompareExpression.Compare(slideVal, val40))
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
            let val80 = CompareExpression.Number(80);

            let extractResult = compare(CompareExpression.Compare(slideVal, val80))
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
                let val100 = CompareExpression.Number(100);

                let readResult = compare(CompareExpression.Compare(slideVal, val100))
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
                    let text = Flag.Read("已经读取完毕,正在执行数据操作...")
                    self.titleLbl?.text = String(text)

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
    case Upload(String)
    //解压
    case Extract(String)
    //读取
    case Read(String)

    //成功或失败
    case IsOK(Int)
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
    case Number(Float)
    indirect case Compare(CompareExpression, CompareExpression)
}

func compare(expression: CompareExpression) -> Float {

    switch expression {
            //直接返回相关值
    case .Number(let value):
        return value

            //比较大小
    case .Compare(let left, let right):
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

struct CompareResult: OptionSetType {
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

