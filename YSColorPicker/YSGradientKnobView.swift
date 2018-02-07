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
    init(color:UIColor) {
        super.init(frame: .zero)
        self.color = color
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func make(_ moveY:Bool = false){
        self.isUserInteractionEnabled = false
        let w = self.frame.size.width
        let h = self.frame.size.height
        let l = CALayer()
        l.shadowColor = UIColor.black.cgColor
        l.shadowOffset = CGSize(width:1, height:1)
        l.shadowOpacity = 0.4
        l.shadowRadius = 2
        
        l.backgroundColor = color.cgColor
        self.layer.addSublayer(l)
        if(moveY){
            l.frame = CGRect(x: -w*0.5, y: -h*0.5, width: w, height: h)
        }else{
            l.frame = CGRect(x: -w*0.5, y: 0, width: w, height: h)
        }
        self.clipsToBounds = false
    }
}
