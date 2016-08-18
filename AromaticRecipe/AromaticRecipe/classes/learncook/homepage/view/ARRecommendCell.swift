//
//  ARRecommendCell.swift
//  AromaticRecipe
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ARRecommendCell: UITableViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    var recommendArray:Array<ARRecommendPhotoModel>?{
        didSet{
            showData()
        }
    }
    
    func showData(){

        let cnt = self.recommendArray?.count
        
        if cnt > 0{
            let containerView = UIView.createView()
            
            self.scrollView.addSubview(containerView)
            
            containerView.snp_makeConstraints {
                [weak self]
                (make) in
                make.edges.equalTo(self!.scrollView)
                make.height.equalTo(self!.scrollView)
            }
            
            var lastView:UIView? = nil
            
            for i in 0..<cnt!{
                let model = self.recommendArray![i]
                
                let imageView = UIImageView.createImageView(nil)
                
                let url = NSURL(string: model.img!)
                imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "backImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(imageView)
                
                imageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(KScreenWidth)
                    if i == 0{
                        make.left.equalTo(containerView)
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                lastView = imageView
            }
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(lastView!)
            })
            
            self.scrollView.pagingEnabled = true
            self.scrollView.delegate = self
            
            self.pageCtrl.numberOfPages = cnt!
        }
    }
    
    class func createRecommendCell(tableView:UITableView, atIndexPath IndexPatn:NSIndexPath,withModel model:ARRecommendModel)->ARRecommendCell{
        
        let cellId = "recommendCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? ARRecommendCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("ARRecommendCell", owner: nil, options: nil).last as? ARRecommendCell
        }
        
        cell?.recommendArray = model.data?.recommend
        
        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension ARRecommendCell:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        
        self.pageCtrl.currentPage = index
    }
    
    
}
