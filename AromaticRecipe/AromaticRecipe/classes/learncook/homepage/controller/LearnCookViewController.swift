//
//  LearnCookViewController.swift
//  AromaticRecipe
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class LearnCookViewController: BaseViewController{
    
    var rView:ARRecommendView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
        downloaderData()
        
        showView()
    }

    
    func showView(){
        self.automaticallyAdjustsScrollViewInsets  = false
        
        self.rView = ARRecommendView()
        
        self.view.addSubview(self.rView!)
        
        rView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
        
    }
    
    func downloaderData(){
        
        let downloader = ARDownloader()
        downloader.delegate = self
        
        downloader.downloaderWithUrlString("http://api.xiangha.com/main6/index/baseData")
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

extension LearnCookViewController:ARDownloaderDelegate{
    
    func downloader(downloader: ARDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: ARDownloader, didFinishWithData data: NSData?) {
        if let jsonData = data{
            let model = ARRecommendModel.parseModel(jsonData)
            dispatch_async(dispatch_get_main_queue(), {
                [weak self] in
                self!.rView?.model = model
            })
        }
    }
    
}








