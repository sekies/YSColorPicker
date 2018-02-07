//
//  YSPickerMainViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/05.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSPickerUnitViewController: YSUnitViewController {
    var brightnessFunc:(()->([CGColor]))!
    var saturationFunc:(()->([CGColor]))!
    var knobChangedFunc:((Double)->())?

    var colorBarBrightness:YSGradientBarView! = YSGradientBarView()

    var minSaturationValue:Double = 0
    var maxSaturationValue:Double = 0
    var _currentSaturationValue:Double = 0
    var currentSaturationValue: Double {
        get{
            return _currentSaturationValue
        }
        
        set{
            _currentSaturationValue = newValue
            update()
        }
    }

    
    var minBrightnessValue:Double = 0
    var maxBrightnessValue:Double = 0
    var _currentBrightnessValue:Double = 0
    var currentBrightnessValue: Double {
        get{
            return _currentBrightnessValue
        }
        
        set{
            _currentBrightnessValue = newValue
            update()
        }
    }

    
    init(
        maxSaturationValue:Double,
        currentSaturationValue:Double,
        maxBrightnessValue:Double,
        currentBrightnessValue:Double,
        colorFunc:@escaping (()->([CGColor]))
        ) {
        super.init(nibName: nil, bundle: nil)
        self.maxSaturationValue = maxSaturationValue
        self.maxBrightnessValue = maxBrightnessValue
        self._currentSaturationValue = currentSaturationValue
        self._currentBrightnessValue = currentBrightnessValue
        self.colorFunc = colorFunc
        rowspan = 2
    }
    
    @available (*, unavailable, message: "Please use the initializer as init(maxSaturationValue:,currentSaturationValue:,maxBrightnessValue:,currentBrightnessValue:,colorFunc:)")
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    @available (*, unavailable, message: "Please use the initializer as init(maxSaturationValue:,currentSaturationValue:,maxBrightnessValue:,currentBrightnessValue:,colorFunc:)")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    @available (*, unavailable, message: "Please use the initializer as init(maxSaturationValue:,currentSaturationValue:,maxBrightnessValue:,currentBrightnessValue:,colorFunc:)")
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bg)
        self.view.addSubview(colorBar)
        self.view.addSubview(colorBarBrightness)
        self.view.addSubview(knob)
        colorBar.movableY = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewDidLayoutSubviews() {
        if(!isInit){
            isInit = true
            let w = self.view.frame.size.width
            let h = self.view.frame.size.height
            bg.frame = CGRect(x: 0, y: 0, width: w, height: h)
            bg.backgroundColor = .clear
            bg.setNeedsDisplay()
            
            colorBar.frame = bg.frame
            colorBarBrightness.frame = bg.frame
            colorBarBrightness.makeY(colors: pickerBrightnessColors())
            colorBarBrightness.isUserInteractionEnabled = false
            knob.frame = CGRect(x: 0, y: 0, width: 9, height: 9)
            knob.make(true)
            
            
            currentSaturationValue = _currentSaturationValue //入れ直して位置を再計算
            currentBrightnessValue = _currentBrightnessValue
            
            update()
        }
    }
    
    override func update(){
        knob.frame.origin.x = max(0,colorBar.frame.width*CGFloat(_currentSaturationValue/maxSaturationValue))
        knob.frame.origin.y = max(0,colorBar.frame.height*CGFloat(_currentBrightnessValue/maxBrightnessValue))

        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            colorBar.make(colors: self.colorFunc())
        CATransaction.commit()
    }
    
    func pickerBrightnessColors()->[CGColor]{
        return [
            UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0).cgColor,
            UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 1).cgColor
        ]
    }
    
}
