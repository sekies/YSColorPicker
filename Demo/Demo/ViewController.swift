//
//  ViewController.swift
//  Demo
//
//  Created by Yosuke Seki on 2018/02/06.
//  Copyright © 2018年 Yosuke Seki. All rights reserved.
//

import UIKit
import YSColorPicker

class ViewController: UIViewController,YSColorsTabViewControllerDelegate {

    
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func pushed(_ sender: Any) {
        let tabvc = YSColorsTabViewController(color: btn.backgroundColor!, colorTypes: [
            .YS_COLOR_PICKER,
            .YS_COLOR_PICKERA,
            .YS_COLOR_RGB,
            .YS_COLOR_RGBA,
            .YS_COLOR_HSB,
            .YS_COLOR_HSBA
            ])
        tabvc.view.backgroundColor = .white
        tabvc.ysColorDelegate = self
        present(tabvc, animated: true, completion: nil)
    }
    
    func ysChanged(color: UIColor) {
        btn.backgroundColor = color
    }
    

}

