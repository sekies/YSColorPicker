//
//  YSPickerViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/05.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSPickerViewController: YSColorLayoutViewController {
    var colorType:YS_COLOR_TYPE = .YS_COLOR_PICKER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        let picker = YSPickerUnitViewController(
            maxSaturationValue: 1,
            currentSaturationValue: Double(s),
            maxBrightnessValue: 1,
            currentBrightnessValue: Double(1-b),
            colorFunc: pickerColors
        )
        
        
        let hue = YSColorUnitViewController(
            name: "Hue:",
            maxValue: 360,
            currentValue: 360*Double(h),
            step: 1,
            colorFunc: huePickerColors
        )
        
        
        var alpha:YSColorUnitViewController?
        if(colorType == .YS_COLOR_PICKERA){
            alpha = YSColorUnitViewController(
                name: "Alpha:",
                maxValue: 100,
                currentValue: 100*Double(a),
                step: 1,
                colorFunc: hsbAlphaPickerColors
            )
            colorControllers = [picker,hue,alpha!]
        }else{
            colorControllers = [picker,hue]
        }
        
        
        
        self.addChildViewController(picker)
        self.view.addSubview(picker.view)
        picker.didMove(toParentViewController: self)
        picker.colorBar.slidedClosure = { (perX:Double) in }
        picker.colorBar.slidedClosureY = { (perX:Double,perY:Double) in
            self.s = CGFloat(perX)
            picker.currentSaturationValue = perX
            self.b = CGFloat(1-perY)
            picker.currentBrightnessValue = perY
            self.allBarsUpdateAndDelegate()
        }
        
        
        
        self.addChildViewController(hue)
        self.view.addSubview(hue.view)
        hue.didMove(toParentViewController: self)
        hue.stepperChangedFunc = { (value:Double) in
            self.h = CGFloat(value/hue.maxValue)
            self.allBarsUpdateAndDelegate()
        }
        hue.colorBar.slidedClosure = { (per:Double) in
            self.h = CGFloat(per)
            hue.currentValue = hue.maxValue*per
            self.allBarsUpdateAndDelegate()
        }
        
        if let al = alpha{
            self.addChildViewController(al)
            self.view.addSubview(al.view)
            al.didMove(toParentViewController: self)
            al.stepperChangedFunc = { (value:Double) in
                self.a = CGFloat(value/al.maxValue)
                self.allBarsUpdateAndDelegate()
            }
            al.colorBar.slidedClosure = { (per:Double) in
                self.a = CGFloat(per)
                al.currentValue = al.maxValue*per
                self.allBarsUpdateAndDelegate()
            }
        }
        
    }
    
    override func setNew(color:UIColor){
        super.setNew(color: color)
        color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        if(colorControllers.count>0){
            if let picker = colorControllers[0] as? YSPickerUnitViewController{
                picker.currentBrightnessValue = Double(1-b)
                picker.currentSaturationValue = Double(s)
                picker.currentValue = Double(h)
            }
        }
        if(colorControllers.count==3){
            colorControllers[1].currentValue = Double(h)*colorControllers[1].maxValue
            colorControllers[2].currentValue = Double(a)*colorControllers[2].maxValue
        }else if(colorControllers.count==2){
            colorControllers[1].currentValue = Double(h)*colorControllers[1].maxValue
        }
    }
    
    override func changed(){
        super.changed()
        delegate?.changed(color: UIColor(hue: h, saturation: s, brightness: b, alpha: a))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    

}
