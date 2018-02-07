//
//  YSBeforeAfterColorViewController.swift
//  YSColorPicker
//
//  Created by Yosuke Seki on 2018/02/06.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit

class YSBeforeAfterColorViewController: UIViewController {
    var isInit:Bool = false
    var beforeTapFunc:(()->())!
    var beforeColor:UIColor = .yellow
    var afterColor:UIColor = .cyan
    var arrowColor:UIColor = .red
    var btnAfter:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(!isInit){
            isInit = true
            
            let w = self.view.frame.size.width
            let h = self.view.frame.size.height
            let arrowW:CGFloat = 20
            let margin:CGFloat = 15
            let btnW:CGFloat = (w-arrowW-margin*2)/2
            
            let btnBefore:UIButton = UIButton()
            btnAfter = UIButton()
            
            btnBefore.layer.borderColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.17).cgColor
            btnAfter!.layer.borderColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.17).cgColor
            btnBefore.layer.borderWidth = 1
            btnAfter!.layer.borderWidth = 1
            
            btnBefore.addTarget(self, action: #selector(YSBeforeAfterColorViewController.beforeTapped(_:)), for: .touchUpInside)
            
            btnBefore.backgroundColor = beforeColor
            btnAfter!.backgroundColor = afterColor
            btnBefore.frame = CGRect(x:0, y:0, width:btnW, height:h)
            btnAfter!.frame = CGRect(x:w-btnW, y:0, width:btnW, height:h)
            
            let arrow = YSArrowView()
            arrow.backgroundColor = .clear
            
            arrow.frame = CGRect(x: btnW+margin, y: 0, width: arrowW, height: h)
            
            self.view.addSubview(btnBefore)
            self.view.addSubview(btnAfter!)
            self.view.addSubview(arrow)
        }
    }
    
    @objc func beforeTapped(_ sendar:UIButton){
        beforeTapFunc()
    }
    
    func update(color:UIColor){
        afterColor = color
        btnAfter?.backgroundColor = afterColor
    }
}
