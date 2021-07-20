//
//  ColorViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/01.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit



class YSColorUnitViewController: YSUnitViewController {
   
    
    var stepperChangedFunc:((Double)->())?
    var name:String = "" //R,G,B,Brightness.. etc

    var margin:CGFloat = 10
    var label:UILabel! = UILabel()
    var stepper:UIStepper! = UIStepper()

    
    init(name:String, maxValue:Double, currentValue:Double, step:Double, colorFunc:@escaping (()->([CGColor]))) {
        super.init(nibName: nil, bundle: nil)
        self.name = name
        self.maxValue = maxValue
        self.stepper.stepValue = step
        self.colorFunc = colorFunc
        self._currentValue = currentValue
    }

    @available (*, unavailable, message: "Please use the initializer as init (name:, maxValue:, currentValue:, step:, colorFunc:")
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    @available (*, unavailable, message: "Please use the initializer as init (name:, maxValue:, currentValue:, step:, colorFunc:")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    @available (*, unavailable, message: "Please use the initializer as init (name:, maxValue:, currentValue:, step:, colorFunc:")
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(label)
        self.view.addSubview(stepper)
        self.view.addSubview(bg)
        self.view.addSubview(colorBar)
        self.view.addSubview(knob)
        
        stepper.maximumValue = maxValue
        stepper.minimumValue = minValue
        stepper.addTarget(
            self,
            action: #selector(YSColorUnitViewController.onStepperChange(stepper:)),
            for: .valueChanged
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            let w = self.view.frame.size.width
            let h = self.view.frame.size.height
            let stepperSize = stepper.frame.size
            label.frame = CGRect(x: 0, y: 0, width: w, height: stepperSize.height)
            label.textColor = .black
            stepper.frame.origin = CGPoint(x: w-stepperSize.width, y: 0)
            bg.frame = CGRect(x: 0, y: stepperSize.height+margin, width: w, height: h-(stepperSize.height+margin))
            bg.backgroundColor = .clear
            bg.setNeedsDisplay()
            
            colorBar.frame = bg.frame
            knob.frame = CGRect(x: 0, y: stepperSize.height+margin, width: 2, height: h-(stepperSize.height+margin))
            knob.make()
            
            currentValue = _currentValue //入れ直して位置を再計算
            update()
    }
    
    override func update(){
        knob.frame.origin.x = max(0,colorBar.frame.width*CGFloat(_currentValue/maxValue))
        stepper.value = _currentValue
        label.text = name + Int(_currentValue).description
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            colorBar.make(colors: self.colorFunc())
        CATransaction.commit()
    }
    
    @objc func onStepperChange(stepper:UIStepper){
        currentValue = stepper.value
        stepperChangedFunc?(stepper.value)
    }
    
    override func finishing(){
        
        label.removeFromSuperview()
        stepper.removeFromSuperview()
        colorBar.removeFromSuperview()
        knob.removeFromSuperview()
        bg.removeFromSuperview()
        
        colorFunc = nil
        stepperChangedFunc = nil
        label = nil
        stepper = nil
        colorBar = nil
        knob = nil
        bg = nil
    }

}
