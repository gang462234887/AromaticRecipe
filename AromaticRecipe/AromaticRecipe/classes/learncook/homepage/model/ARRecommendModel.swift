//
//  ARRecommendModel.swift
//  AromaticRecipe
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import SwiftyJSON

class ARRecommendModel: NSObject {
    
    var res:NSNumber?
    var data:ARRecommendDataModel?
    
    class func parseModel(data:NSData)->ARRecommendModel{
        let model = ARRecommendModel()
        let jsonData = JSON(data: data)
        
        model.res = jsonData["res"].number
        
        let jsonDict = jsonData["data"]
        model.data = ARRecommendDataModel.parseModel(jsonDict)
        
        return model
    }

}

class ARRecommendDataModel: NSObject {
    var recommend:Array<ARRecommendPhotoModel>?
    var activeUser:Array<ARRecommendUserModel>?
    var nous:Array<ARRecommendNousModel>?
    var topic:Array<ARRecmmondTopicModel>?
    
    class func parseModel(jsonData:JSON)->ARRecommendDataModel{
        let model = ARRecommendDataModel()
        
        let recommendArray = jsonData["recommend"]
        var rArray = Array<ARRecommendPhotoModel>()
        
        for (_,subjson) in recommendArray{
            let photoModel = ARRecommendPhotoModel.parseModel(subjson)
            rArray.append(photoModel)
        }
        model.recommend = rArray
        
        let userArray = jsonData["activeUser"]
        var uArray = Array<ARRecommendUserModel>()
        
        for (_, subjson) in userArray{
            let userModel = ARRecommendUserModel.parseModel(subjson)
            uArray.append(userModel)
        }
        model.activeUser = uArray
        
        let nousArray = jsonData["nous"]
        var nArray = Array<ARRecommendNousModel>()
        
        for (_, subJson) in nousArray{
            let nousModel = ARRecommendNousModel.parseModel(subJson)
            nArray.append(nousModel)
        }
        model.nous = nArray
        
        let topicArray = jsonData["topic"]
        var tArray = Array<ARRecmmondTopicModel>()
        for (_,subJson) in topicArray{
            let topicModel = ARRecmmondTopicModel.parseModel(subJson)
            tArray.append(topicModel)
        }
        model.topic = tArray
        
        return model
    }
}

class ARRecommendPhotoModel: NSObject {
    var title:String?
    var date:String?
    var type:NSNumber?
    
    var time:String?
    var url:String?
    var img:String?
    
    class func parseModel(jsonData:JSON)->ARRecommendPhotoModel{
        let model = ARRecommendPhotoModel()
        
        model.title = jsonData["title"].string
        model.date = jsonData["date"].string
        model.type = jsonData["type"].number
        model.time = jsonData["time"].string
        model.url = jsonData["url"].string
        model.img = jsonData["img"].string
        
        return model
    }
    
 
}

class ARRecommendUserModel: NSObject {
    
    var code:NSNumber?
    var nickName:String?
    var img:String?
    
    var hotNum:NSNumber?
    var isGourmet:String?
    
    class func parseModel(jsonData:JSON)->ARRecommendUserModel{
        let model = ARRecommendUserModel()
        model.code = jsonData["code"].number
        model.nickName = jsonData["nickName"].string
        model.img = jsonData["img"].string
        model.hotNum = jsonData["hotNum"].number
        model.isGourmet = jsonData["isGourmet"].string
        
        return model
    }
}

class ARRecommendNousModel: NSObject {
    var code:NSNumber?
    var title:String?
    var allClick:String?
    
    var classifyname:String?
    var commentCount:String?
    var img:String?
    
    var isUrl:String?
    
    class func parseModel(jsonData:JSON)->ARRecommendNousModel{
        let model = ARRecommendNousModel()
        
        model.code = jsonData["code"].number
        model.title = jsonData["title"].string
        model.allClick = jsonData["allClick"].string
        
        model.classifyname = jsonData["classifyname"].string
        model.commentCount = jsonData["commentCount"].string
        model.img = jsonData["img"].string
        
        model.isUrl = jsonData["isUrl"].string
        
        return model
    }
    
}

class ARRecmmondTopicModel: NSObject {
    
    var title:String?
    var subtitle:String?
    var desc:String?
    
    var url:String?
    var imgs:String?
    
    class func parseModel(jsonData:JSON)->ARRecmmondTopicModel{
        let model = ARRecmmondTopicModel()
        
        model.title = jsonData["title"].string
        model.subtitle = jsonData["subtitle"].string
        model.desc = jsonData["desc"].string
        
        model.url = jsonData["url"].string
        model.imgs = jsonData["imgs"].string
        
        return model
    }
    
}







