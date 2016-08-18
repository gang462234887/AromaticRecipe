//
//  MainTabBarController.swift
//  AromaticRecipe
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var bgView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.hidden = true
        createViewControllers()
    }
    
    
    func createViewControllers(){
        
        let ctrlNames = ["LearnCookViewController","MallViewController","CommunityViewController","MessageViewController","MyViewController"]
        let imageNames = ["z_home_menu_ico_caipu@2x","z_home_menu_ico_surprise@2x","z_home_menu_ico_quan@2x","z_home_menu_ico_message@2x","z_home_menu_ico_me@2x"]
        let selectImageNames = ["z_home_menu_ico_caipu_active@2x","z_home_menu_ico_surprise_active@2x","z_home_menu_ico_quan_active@2x","z_home_menu_ico_message_active@2x","z_home_menu_ico_me_active@2x"]
        let titleNames = ["学做菜","商城","社区","消息","我的"]
        
        var vCtrlArray = Array<UINavigationController>()
        
        for i in 0..<ctrlNames.count{
            
            let ctrlName = "AromaticRecipe." + ctrlNames[i]
            
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let vCtrl = cls.init()
            
            let navCtrl = UINavigationController(rootViewController: vCtrl)
            vCtrlArray.append(navCtrl)
            
            createCoutomTabBar(imageNames, selectImageNames: selectImageNames, titleNames: titleNames)
        }
        
        self.viewControllers = vCtrlArray
    }
    
    func createCoutomTabBar(imageNames:[String],selectImageNames:[String],titleNames:[String]){
        
        bgView = UIView()
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(bgView!)
        
        bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view.snp_bottom).offset(-49)
            
        })
        
        let width = KScreenWidth/5.0
        
        for i in 0..<imageNames.count{
            
            let btn = UIButton.createBtn(nil, bgImageNmae: imageNames[i], selectImageName: selectImageNames[i], target: self, action: #selector(clickBtn(_:)))
            btn.tag = 300+i
            bgView!.addSubview(btn)
            
           
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
                
                })
            
            let label = UILabel.createLabel(titleNames[i], font: UIFont.systemFontOfSize(9), textAlignment: .Center, textColor: UIColor.grayColor())
            label.tag = 400
            btn.addSubview(label)
            
            label.snp_makeConstraints(closure: {
                (make) in
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(35)
                make.height.equalTo(12)
            })
            if i == 0{
                btn.selected = true
                label.textColor = UIColor.redColor()
            }
        }
        
    }

    
    func clickBtn(btn:UIButton){
        let lastBtnView = self.bgView?.viewWithTag(300+self.selectedIndex)
        if let lastView = lastBtnView {
            let lastBtn = lastView as! UIButton
            let lastLabelView = lastView.viewWithTag(400)
            if let tmpLabel = lastLabelView{
                let lastLabel = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
        }
        
        let curLabelView = btn.viewWithTag(400)
        if let tmpView = curLabelView{
            let curLabel = tmpView as! UILabel
            curLabel.textColor = UIColor.redColor()
            btn.selected = true
        }
        
        self.selectedIndex = btn.tag - 300
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
