//
//  HSBViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/01.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSHSBViewController: YSColorLayoutViewController {
    var colorType:YS_COLOR_TYPE = .YS_COLOR_HSBA
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        let hue = YSColorUnitViewController(
            name: "Hue:",
            maxValue: 360,
            currentValue: 360*Double(h),
            step: 1,
            colorFunc: huePickerColors
        )
        
        let saturation = YSColorUnitViewController(
            name: "Saturation:",
            maxValue: 100,
            currentValue: 100*Double(s),
            step: 1,
            colorFunc: satPickerColors
        )
        
        let brightness = YSColorUnitViewController(
            name: "Brightness:",
            maxValue: 100,
            currentValue: 100*Double(b),
            step: 1,
            colorFunc: briPickerColors
        )

        var alpha:YSColorUnitViewController?
        if(colorType == .YS_COLOR_HSBA){
            alpha = YSColorUnitViewController(
                name: "Alpha:",
                maxValue: 100,
                currentValue: 100*Double(a),
                step: 1,
                colorFunc: hsbAlphaPickerColors
            )
            colorControllers = [hue,saturation,brightness,alpha!]
        }else{
            colorControllers = [hue,saturation,brightness]
        }
        
        
        self.addChild(hue)
        self.view.addSubview(hue.view)
        hue.didMove(toParent: self)
        hue.stepperChangedFunc = { (value:Double) in
            self.h = CGFloat(value/hue.maxValue)
            self.allBarsUpdateAndDelegate()
        }
        hue.colorBar.slidedClosure = { (per:Double) in
            self.h = CGFloat(per)
            hue.currentValue = hue.maxValue*per
            self.allBarsUpdateAndDelegate()
        }
        
        
        
        self.addChild(saturation)
        self.view.addSubview(saturation.view)
        saturation.didMove(toParent: self)
        saturation.stepperChangedFunc = { (value:Double) in
            self.s = CGFloat(value/saturation.maxValue)
            self.allBarsUpdateAndDelegate()
        }
        saturation.colorBar.slidedClosure = { (per:Double) in
            self.s = CGFloat(per)
            saturation.currentValue = saturation.maxValue*per
            self.allBarsUpdateAndDelegate()
        }
        
        
        self.addChild(brightness)
        self.view.addSubview(brightness.view)
        brightness.didMove(toParent: self)
        brightness.stepperChangedFunc = { (value:Double) in
            self.b = CGFloat(value/brightness.maxValue)
            self.allBarsUpdateAndDelegate()
        }
        brightness.colorBar.slidedClosure = { (per:Double) in
            self.b = CGFloat(per)
            brightness.currentValue = brightness.maxValue*per
            self.allBarsUpdateAndDelegate()
        }
        
        
        if let al = alpha{
            self.addChild(al)
            self.view.addSubview(al.view)
            al.didMove(toParent: self)
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

        if(colorControllers.count==4){
            colorControllers[0].currentValue = Double(h)*colorControllers[0].maxValue
            colorControllers[1].currentValue = Double(s)*colorControllers[1].maxValue
            colorControllers[2].currentValue = Double(b)*colorControllers[2].maxValue
            colorControllers[3].currentValue = Double(a)*colorControllers[3].maxValue
        }else if(colorControllers.count==3){
            colorControllers[0].currentValue = Double(h)*colorControllers[0].maxValue
            colorControllers[1].currentValue = Double(s)*colorControllers[1].maxValue
            colorControllers[2].currentValue = Double(b)*colorControllers[2].maxValue
        }
    }
    
    override func changed(){
        super.changed()
        delegate?.changed(color: UIColor(hue: h, saturation: s, brightness: b, alpha: a))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
