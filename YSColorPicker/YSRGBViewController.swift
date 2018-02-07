//
//  RGBViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/01.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit


class YSRGBViewController: YSColorLayoutViewController {
    var colorType:YS_COLOR_TYPE = .YS_COLOR_RGBA


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        
        let red = YSColorUnitViewController(
            name: "Red:",
            maxValue: 255,
            currentValue: 255*Double(r),
            step: 1,
            colorFunc: redPickerColors
        )
        let green = YSColorUnitViewController(
            name: "Green:",
            maxValue: 255,
            currentValue: 255*Double(g),
            step: 1,
            colorFunc: greenPickerColors
        )
        let blue = YSColorUnitViewController(
            name: "Blue:",
            maxValue: 255,
            currentValue: 255*Double(b),
            step: 1,
            colorFunc: bluePickerColors
        )
        
        var alpha:YSColorUnitViewController?
        if(colorType == .YS_COLOR_RGBA){
            alpha = YSColorUnitViewController(
                name: "Alpha:",
                maxValue: 100,
                currentValue: 100*Double(a),
                step: 1,
                colorFunc: alphaPickerColors
            )
            colorControllers = [red,green,blue,alpha!]
        }else{
            colorControllers = [red,green,blue]
        }
        
        
        
        
        
        self.addChildViewController(red)
        self.view.addSubview(red.view)
        red.didMove(toParentViewController: self)
        red.stepperChangedFunc = { (value:Double) in
            self.r = CGFloat(value/red.maxValue)
            self.allBarsUpdateAndDelegate()
        }
        red.colorBar.slidedClosure = { (per:Double) in
            self.r = CGFloat(per)
            red.currentValue = red.maxValue*per
            self.allBarsUpdateAndDelegate()
        }
        
        
        
        
        
        self.addChildViewController(green)
        self.view.addSubview(green.view)
        green.didMove(toParentViewController: self)
        green.stepperChangedFunc = { (value:Double) in
            self.g = CGFloat(value/green.maxValue)
            self.allBarsUpdateAndDelegate()
        }
        green.colorBar.slidedClosure = { (per:Double) in
            self.g = CGFloat(per)
            green.currentValue = green.maxValue*per
            self.allBarsUpdateAndDelegate()
        }
        
        
        
        
        self.addChildViewController(blue)
        self.view.addSubview(blue.view)
        blue.didMove(toParentViewController: self)
        blue.stepperChangedFunc = { (value:Double) in
            self.b = CGFloat(value/blue.maxValue)
            self.allBarsUpdateAndDelegate()
        }
        blue.colorBar.slidedClosure = { (per:Double) in
            self.b = CGFloat(per)
            blue.currentValue = blue.maxValue*per
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
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if(colorControllers.count==4){
            colorControllers[0].currentValue = Double(r)*colorControllers[0].maxValue
            colorControllers[1].currentValue = Double(g)*colorControllers[1].maxValue
            colorControllers[2].currentValue = Double(b)*colorControllers[2].maxValue
            colorControllers[3].currentValue = Double(a)*colorControllers[3].maxValue
        }else if(colorControllers.count==3){
            colorControllers[0].currentValue = Double(r)*colorControllers[0].maxValue
            colorControllers[1].currentValue = Double(g)*colorControllers[1].maxValue
            colorControllers[2].currentValue = Double(b)*colorControllers[2].maxValue
        }
    }
    
    override func changed(){
        super.changed()
        delegate?.changed(color: UIColor.init(red: r, green: g, blue: b, alpha: a))
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
