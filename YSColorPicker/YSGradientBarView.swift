//
//  GradientBarView.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/01.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSGradientBarView: UIView {
    let colorGradient = CAGradientLayer()
    var slidedClosure: ((Double) -> ())!
    var slidedClosureY: ((Double,Double) -> ())?
    var movableY:Bool = false
    
    init() {
        super.init(frame: .zero)
        self.layer.addSublayer(colorGradient)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func make(colors:[CGColor]){
        colorGradient.startPoint = CGPoint(x: 1, y: 0.5)
        colorGradient.endPoint = CGPoint(x: 0, y: 0.5)
        colorGradient.colors = colors
        colorGradient.frame = self.bounds
    }
    
    func makeY(colors:[CGColor]){
        colorGradient.startPoint = CGPoint(x: 0.5, y: 0)
        colorGradient.endPoint = CGPoint(x: 0.5, y: 1)
        colorGradient.colors = colors
        colorGradient.frame = self.bounds
    }
    

    
    
    //MARK: - パーセント取得
    func getPer(x:Double) -> Double{
        let per = min(1.0, max(0, x/Double(self.frame.width)))
        return per
    }
    
    func getPer(y:Double) -> Double{
        let per = min(1.0, max(0, y/Double(self.frame.height)))
        return per
    }
    
    
    //MARK: - タッチ関連
    func calc(touch:UITouch){
        let p = touch.location(in: self)
        let x = Double(max(0, min(self.frame.width, p.x)))
        if(movableY){
            let y = Double(max(0, min(self.frame.height, p.y)))
            slidedClosureY?(getPer(x:x),getPer(y:y))
        }else{
            slidedClosure(getPer(x:x))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(touches.count == 1){
            if let t = touches.first{
                calc(touch:t)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(touches.count == 1){
            if let t = touches.first{
                calc(touch:t)
            }
        }
    }
    
}
