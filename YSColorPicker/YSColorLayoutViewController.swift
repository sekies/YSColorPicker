//
//  YSColorLayoutViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/02.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit


public enum YS_COLOR_TYPE:String {
    case YS_COLOR_RGBA = "RGBA"
    case YS_COLOR_RGB = "RGB"
    case YS_COLOR_HSBA = "HSBA"
    case YS_COLOR_HSB = "HSB"
    case YS_COLOR_PICKER = "Picker"
    case YS_COLOR_PICKERA = "PickerA"
}



protocol YSColorLayoutViewControllerDelegate {
    func changed(color:UIColor)
    func finished()
    func getDefaultColor() -> UIColor
}

class YSColorLayoutViewController: UIViewController {
    static let is_iPhoneX: Bool =  {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone10,3", "iPhone10,6":
            return true
        default:
            return false
        }
    }()
    
    var aftColor:UIColor? = nil
    var delegate:YSColorLayoutViewControllerDelegate?
    var colorControllers:[YSUnitViewController] = []
    var isLayouted:Bool = false
    var doneBtn:UIButton! = UIButton()
    var beforeAfter:YSBeforeAfterColorViewController? = YSBeforeAfterColorViewController()
    var r:CGFloat = 0.0
    var g:CGFloat = 0.0
    var b:CGFloat = 0.0
    var h:CGFloat = 0.0
    var s:CGFloat = 0.0
    var a:CGFloat = 1.0
    
    override var prefersStatusBarHidden: Bool {
        return !YSColorLayoutViewController.is_iPhoneX
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        if(!isLayouted){
            isLayouted = true
            
            let w = self.view.frame.size.width
            let h = self.view.frame.size.height
            let marginLR:CGFloat = 35
            let marginTB:CGFloat = 30
            let beforeAfterHeight:CGFloat = 30
            let fullWidth = w-marginLR*2
            
            self.addChild(beforeAfter!)
            self.view.addSubview(beforeAfter!.view)
            beforeAfter!.beforeColor = (delegate?.getDefaultColor())!
            if let ac = aftColor{
                beforeAfter!.afterColor = ac
            }else{
                beforeAfter!.afterColor = (delegate?.getDefaultColor())!
            }
            beforeAfter!.didMove(toParent: self)
            beforeAfter!.view.frame = CGRect(x: marginLR, y: marginTB, width: fullWidth, height: beforeAfterHeight)
            beforeAfter!.beforeTapFunc = {
                self.setNew(color: (self.delegate?.getDefaultColor())!)
                self.allBarsUpdateAndDelegate()
            }
            
            
            var count:CGFloat = 0
            for vc in colorControllers{
                count += vc.rowspan
            }
            let countM1:CGFloat = count-1
            
            let maxSpace:CGFloat = 45
            var space:CGFloat = 10
            let doneHeight:CGFloat = 50
            let maxHeight:CGFloat = 150
            var top:CGFloat = marginTB+beforeAfterHeight
            var height = min((h - top - doneHeight - marginTB*3 - space*countM1)/count, maxHeight)
            
            
            self.view.addSubview(doneBtn)
            doneBtn.setTitle("OK", for: .normal)
            doneBtn.addTarget(self, action: #selector(YSColorLayoutViewController.donePushed(_:)), for: .touchUpInside)
            doneBtn.setTitleColor(.black, for: .normal)
            
            if #available(iOS 11.0, *) {
                let insets = self.view.safeAreaInsets
                
                beforeAfter!.view.frame = CGRect(x: marginLR, y: marginTB+insets.top, width: fullWidth, height: beforeAfterHeight)
                
                height = min((h - doneHeight - marginTB*3 - space*countM1 - insets.top - insets.bottom)/count,maxHeight)
                if(height == maxHeight){
                    space = min((h - height*count - doneHeight - marginTB*3 - insets.top - insets.bottom)/countM1,maxSpace)
                }
                top = marginTB+beforeAfterHeight+insets.top
                
            }else{
                if(height == maxHeight){
                    space = min((h - height*count - doneHeight - marginTB*3)/countM1, maxSpace)
                }
            }
            
            
            
            doneBtn.frame = CGRect(x: 0, y: h-self.tabBarController!.tabBar.frame.size.height-doneHeight, width: w, height: doneHeight)
            
            var targetY:CGFloat =  top+marginTB
            for vc in colorControllers {
                vc.view.frame = CGRect(x: marginLR, y:targetY, width: fullWidth, height: height*vc.rowspan)
                targetY += +space+height*vc.rowspan
            }
        }
    }
    
    func setAfter(color:UIColor){
        aftColor = color
        beforeAfter!.update(color:aftColor!)
    }
    
    func setNew(color:UIColor){
        setAfter(color: color)
    }
    
    func allBarsUpdateAndDelegate(){
        for vc in colorControllers {
            vc.update()
        }
        changed()
    }
    
    
    
    func allBarsUpdate(){
        for vc in colorControllers {
            vc.update()
        }
    }
    
    func changed(){
    }
    
    func finishing(){
        beforeAfter?.removeFromParent()
        beforeAfter?.view.removeFromSuperview()
        beforeAfter = nil
        doneBtn.removeFromSuperview()
        doneBtn = nil
        delegate = nil
        for vc in colorControllers{
            vc.finishing()
        }
        colorControllers.removeAll()
    }
    
    @objc func donePushed(_ sender:Any){
        delegate?.finished()
    }
    
    
    
    
    
    
    //各属性Bar用のカラー配列を生成 この配列からグラデーションを作る
    func redPickerColors()->[CGColor]{
        return [
            UIColor(red: 1, green: g, blue: b, alpha: a).cgColor,
            UIColor(red: 0, green: g, blue: b, alpha: a).cgColor
        ]
    }
    
    func greenPickerColors()->[CGColor]{
        return [
            UIColor(red: r, green: 1, blue: b, alpha: a).cgColor,
            UIColor(red: r, green: 0, blue: b, alpha: a).cgColor
        ]
    }
    
    func bluePickerColors()->[CGColor]{
        return [
            UIColor(red: r, green: g, blue: 1, alpha: a).cgColor,
            UIColor(red: r, green: g, blue: 0, alpha: a).cgColor
        ]
    }
    
    func alphaPickerColors()->[CGColor]{
        return [
            UIColor(red: r, green: g, blue: b, alpha: 1).cgColor,
            UIColor(red: r, green: g, blue: b, alpha: 0).cgColor
        ]
    }
    
    func hsbAlphaPickerColors()->[CGColor]{
        return [
            UIColor(hue: h, saturation: s, brightness: b, alpha: 1).cgColor,
            UIColor(hue: h, saturation: s, brightness: b, alpha: 0).cgColor
        ]
    }
    
    func huePickerColors()->[CGColor]{
        var colors:[CGColor] = []
        let stride1 = stride(from: 1, to: 0, by: -0.05)
        for i in stride1 {
            colors.append(
                UIColor.init(
                    hue: CGFloat(i),
                    saturation: s,
                    brightness: b,
                    alpha: a
                    ).cgColor
            )
        }
        return colors
    }
    
    func satPickerColors()->[CGColor]{
        return [
            UIColor(hue: h, saturation: 1, brightness: b, alpha: a).cgColor,
            UIColor(hue: h, saturation: 0, brightness: b, alpha: a).cgColor
        ]
    }
    
    
    func briPickerColors()->[CGColor]{
        return [
            UIColor(hue: h, saturation: s, brightness: 1, alpha: a).cgColor,
            UIColor(hue: h, saturation: s, brightness: 0, alpha: a).cgColor
        ]
    }
    
    
    func pickerColors()->[CGColor]{
        return [
            UIColor(hue: h, saturation: 1, brightness: 1, alpha: a).cgColor,
            UIColor(hue: h, saturation: 0, brightness: 1, alpha: a).cgColor
        ]
    }
    
}

