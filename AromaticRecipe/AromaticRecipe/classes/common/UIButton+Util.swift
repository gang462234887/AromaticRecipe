//
//  UIButton+Util.swift
//  AromaticRecipe
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

extension UIButton{
    
    class func createBtn(title:String?,bgImageNmae:String?,selectImageName:String?,target:AnyObject?,action:Selector)->UIButton{
        
        let btn = UIButton(type: .Custom)
        if let btnTitle = title{
            btn.setTitle(btnTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if let btnBgImageName = bgImageNmae{
            btn.setImage(UIImage(named: btnBgImageName), forState: .Normal)
        }
        if let btnSelectImageName = selectImageName{
            btn.setImage(UIImage(named: btnSelectImageName), forState: .Selected)
        }
        if let btnTarget = target{
            btn.addTarget(btnTarget, action: action, forControlEvents: .TouchUpInside)
        }
        
        return btn
    }
    
    
}


