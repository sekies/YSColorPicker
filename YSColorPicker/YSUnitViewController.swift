//
//  YSUnitViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/05.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSUnitViewController: UIViewController {
    var rowspan:CGFloat = 1
    var colorFunc:(()->([CGColor]))!
    var isInit:Bool = false
    var minValue:Double = 0
    var maxValue:Double = 0
    var _currentValue:Double = 0
    var currentValue: Double {
        get{
            return _currentValue
        }
        
        set{
            _currentValue = newValue
            update()
        }
    }
    var colorBar:YSGradientBarView! = YSGradientBarView()
    var knob:YSGradientKnobView! = YSGradientKnobView(color: .white)
    var bg:UIView! = YSBarBgView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(){
    }
    
    func finishing(){
        
    }
}
