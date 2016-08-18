//
//  ARDownloader.swift
//  AromaticRecipe
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol ARDownloaderDelegate:NSObjectProtocol {
    
    func downloader(downloader:ARDownloader,didFailWithError error:NSError)
    
    func downloader(downloader:ARDownloader,didFinishWithData data:NSData?)
}

class ARDownloader: NSObject {
    weak var delegate:ARDownloaderDelegate?
    
    func downloaderWithUrlString(urlString:String){
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if error != nil{
                self.delegate?.downloader(self, didFailWithError: error!)
            }else{
                let httpRes = response as! NSHTTPURLResponse
                if httpRes.statusCode == 200{
                    if data != nil{
                        self.delegate?.downloader(self, didFinishWithData: data)
                    }
                }else{
                    print("下载失败")
                }
            }
        }
        task.resume()
    }

}
