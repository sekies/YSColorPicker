//
//  YSBarBgView.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/02.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSBarBgView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let size:CGFloat = 10
        let w = self.frame.size.width
        let h = self.frame.size.height
        for y in 0...Int(ceil(h/size)) {
            for x in 0...Int(ceil(w/size)) {
                if(y%2 == 0){
                    if(x%2 == 0){
                        UIColor.lightGray.setFill()
                    }else{
                        UIColor.gray.setFill()
                    }
                }else{
                    if(x%2 == 0){
                        UIColor.gray.setFill()
                    }else{
                        UIColor.lightGray.setFill()
                    }
                }
                let rectangle = UIBezierPath(rect: CGRect(
                    x: CGFloat(x)*size,
                    y: CGFloat(y)*size,
                    width: size,
                    height: size
                ))
                rectangle.lineWidth = 0
                rectangle.fill()
            }
        }
    }

}
