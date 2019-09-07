//
//  UIBaraaButtonItem-Extension.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/7.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    //便利构造函数
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero) {
    
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName),for:.normal)
        if highImageName != ""{
            btn.setImage(UIImage(named: highImageName),for:.highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }

        
        self.init(customView : btn)
    }
}
