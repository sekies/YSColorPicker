//
//  YSArrowView.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/06.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSArrowView: UIView {
    var color:UIColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    var borderColorf:UIColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.25)
    override func draw(_ rect: CGRect) {
        let w = self.frame.size.width
        let h = self.frame.size.height
        let margin:CGFloat = 5
        let triangle = UIBezierPath();
        triangle.move(to: CGPoint(x: 0, y: margin));
        triangle.addLine(to: CGPoint(x: w, y: margin+(h-margin*2)*0.5));
        triangle.addLine(to: CGPoint(x: 0, y: h-margin));
        triangle.close()
        color.setFill()
        borderColorf.setStroke()
        triangle.fill()
        triangle.lineWidth = 1
        triangle.stroke()
    }
 

}
