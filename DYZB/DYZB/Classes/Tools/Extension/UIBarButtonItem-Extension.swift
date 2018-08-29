//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by byron on 2018/8/29.
//  Copyright © 2018年 byron. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
//    class func createItem(imageName:String, higlightedImageName:String, size:CGSize)->UIBarButtonItem{
//        let btn = UIButton()
//        btn.setImage(UIImage(named:imageName), for: .normal)
//        btn.setImage(UIImage(named:higlightedImageName), for: .highlighted)
//        btn.frame = CGRect(origin:CGPoint.zero, size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    convenience init(imageName:String, higlightedImageName:String = "", size:CGSize = CGSize.zero){
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if higlightedImageName != "" {
            btn.setImage(UIImage(named:higlightedImageName), for: .highlighted)
        }
        if size != CGSize.zero {
            btn.frame = CGRect(origin:CGPoint.zero, size: size)

        }else{
            btn.sizeToFit()
        }
        
        btn.frame = CGRect(origin:CGPoint.zero, size: size)
        self.init(customView: btn)
    }
}
