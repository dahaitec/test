//
//  UIColor-Extension.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/8.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red:r / 255.0,green: g/255.0,blue: b/255.0,alpha:1.0)
    }
}

