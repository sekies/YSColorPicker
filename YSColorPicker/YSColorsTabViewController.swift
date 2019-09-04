//
//  YSColorsTabViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/02.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

public protocol YSColorsTabViewControllerDelegate {
    func ysChanged(color:UIColor)
}

public class YSColorsTabViewController: UITabBarController,YSColorLayoutViewControllerDelegate {
    var defaultColor:UIColor!
    public var ysColorDelegate:YSColorsTabViewControllerDelegate?
    var colorTypes:[YS_COLOR_TYPE] = []
    var controllers:[YSColorLayoutViewController] = []
    
    
    
    
    public init(color:UIColor,colorTypes:[YS_COLOR_TYPE]) {
        self.defaultColor = color
        self.colorTypes = colorTypes
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable, message: "Please use the initializer as init(color:)")
    public init(){
        super.init(nibName: nil, bundle: nil)
    }
    @available (*, unavailable, message: "Please use the initializer as init(color:)")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    @available (*, unavailable, message: "Please use the initializer as init(color:)")
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        for (i,ct) in colorTypes.enumerated() {
            switch ct {
            case .YS_COLOR_RGB, .YS_COLOR_RGBA:
                let rgb:YSRGBViewController! = YSRGBViewController()
                rgb.setNew(color: defaultColor)
                rgb.tabBarItem = UITabBarItem.init(title: ct.rawValue, image: nil, tag: i)
                rgb.delegate = self
                rgb.colorType = ct
                controllers.append(rgb)
                break
            case .YS_COLOR_HSB, .YS_COLOR_HSBA:
                let hsb:YSHSBViewController! = YSHSBViewController()
                hsb.setNew(color: defaultColor)
                hsb.tabBarItem = UITabBarItem.init(title: ct.rawValue, image: nil, tag: i)
                hsb.delegate = self
                hsb.colorType = ct
                controllers.append(hsb)
                break
            case .YS_COLOR_PICKER, .YS_COLOR_PICKERA:
                let picker:YSPickerViewController! = YSPickerViewController()
                picker.setNew(color: defaultColor)
                picker.tabBarItem = UITabBarItem.init(title: ct.rawValue, image: nil, tag: i)
                picker.delegate = self
                picker.colorType = ct
                controllers.append(picker)
                break
            }
        }
        setViewControllers(controllers, animated: false)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 13)!], for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -9)
    }
    
    func getDefaultColor() -> UIColor{
        return defaultColor
    }
    func changed(color: UIColor) {
        
        for (i,vc) in controllers.enumerated() {
            if(i != self.selectedIndex){
                vc.setNew(color: color)
            }else{
                vc.setAfter(color: color)
            }
        }
        ysColorDelegate?.ysChanged(color:color)
    }
    
    func finished() {
        self.dismiss(animated: true, completion: {
            for vc in self.controllers {
                vc.finishing()
                vc.removeFromParent()
            }
            self.controllers.removeAll()
            self.defaultColor = nil
            self.ysColorDelegate = nil
        })
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
