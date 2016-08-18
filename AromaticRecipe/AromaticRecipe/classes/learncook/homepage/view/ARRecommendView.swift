//
//  ARRecommendView.swift
//  AromaticRecipe
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ARRecommendView: UIView {

    private var tbView:UITableView?
    
    var model:ARRecommendModel?{
        didSet{
            self.tbView?.reloadData()
        }
    }
    
    init() {
        super.init(frame: CGRectZero)
        
        self.tbView = UITableView(frame: CGRectZero, style: .Plain)
        self.tbView?.delegate = self
        self.tbView?.dataSource  = self
        self.addSubview(self.tbView!)
        
        self.tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ARRecommendView:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 1
        
        if section == 0{
            if model?.data?.recommend?.count > 0{
                rowNum = 1
            }
        }
        return rowNum
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.section == 0{
            if self.model?.data?.recommend?.count > 0{
                
                cell = ARRecommendCell.createRecommendCell(tableView, atIndexPath: indexPath, withModel: model!)
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0{
            if model?.data?.recommend?.count > 0{
                height = 160
            }
        }
        
        return height
    }
}







