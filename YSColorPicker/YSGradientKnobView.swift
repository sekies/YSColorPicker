//
//  GradientKnobView.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/01.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSGradientKnobView: UIView {
    var color:UIColor = .white
    
    let barLayer = CALayer()
    
    init(color:UIColor) {
        super.init(frame: .zero)
        self.color = color
        makeBar()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeBar() {
        barLayer.shadowColor = UIColor.black.cgColor
        barLayer.shadowOffset = CGSize(width:1, height:1)
        barLayer.shadowOpacity = 0.4
        barLayer.shadowRadius = 2
        barLayer.backgroundColor = color.cgColor
        layer.addSublayer(barLayer)
    }
    
    func make(_ moveY:Bool = false){
        isUserInteractionEnabled = false
        let w = frame.size.width
        let h = frame.size.height

        if(moveY){
            barLayer.frame = CGRect(x: -w*0.5, y: -h*0.5, width: w, height: h)
        }else{
            barLayer.frame = CGRect(x: -w*0.5, y: 0, width: w, height: h)
        }
        clipsToBounds = false
    }
}
