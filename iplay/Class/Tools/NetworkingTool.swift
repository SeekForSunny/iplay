//
//  NetworkingTool.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/24.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import Alamofire

//咨询
//头条:https://i.play.163.com/news/article/list/T1461396257593/0/20?todayFirstRequest=false
//关注:https://i.play.163.com/news/article/attention_article_list/0/20

//精选
//最新推荐
//banner:https://i.play.163.com/news/config/config_focus_img/list/
//list:https://i.play.163.com/news/config/config_recommend_article/list
//精选专栏
//https://i.play.163.com/news/new_topic/list?topicType=2
//https://i.play.163.com/news/articleUpdate/T1428028756927%7CD48VFG2700318QIP%2CT1428028626744%7CCU4K0K6F00318QL3%2CIT1476772755839%7CD3S26FNB00318QE8?version=v2


//社区
//热门推荐:
//第一页:https://i.play.163.com/news/discuz/hot_recommend/1/20
//第二页:https://i.play.163.com/news/discuz/hot_recommend/2/20
//爱玩社区:https://i.play.163.com/news/discuz/discuz_model_v2/list/center/0

enum NetAPI:String{
    
    /**咨询 -- 头条*/
    case TodayFirst = "/article/list/T1461396257593/"
    /**咨询 -- 关注*/
    case Atention = "/article/attention_article_list/"
    
    /**精选 -- 最新推荐 - banner*/
    case ConfigImg = "/config/config_focus_img/list/"
    /**精选 -- 最新推荐 - list*/
    case ReconmentList = "/config/config_recommend_article/list"
    /**精选 -- 精选专栏*/
    case NewTopic = "/new_topic/list?topicType=2"
    /**精选 -- 精选专栏*/
    case ArticleUpdate = "/T1428028756927%7CD48VFG2700318QIP%2CT1428028626744%7CCU4K0K6F00318QL3%2CIT1476772755839%7CD3S26FNB00318QE8?version=v2"
    
    /**社区 -- 热门推荐*/
    case Discuz = "/discuz/hot_recommend/"
    /**社区 -- 爱玩社区*/
    case Discuz_2 = "/discuz/discuz_model_v2/list/center/0"
    
}

class NetworkingTool {
    
    let BASE_URL = "https://i.play.163.com/news"
    
    static let shareInstance = NetworkingTool()
    let reachabilityManager = NetworkReachabilityManager.init()
    
    typealias Completion = ((_ response:[String:Any]?,_ error:Any?)->())
    private var competion:Completion?
    
    func request(method:HTTPMethod = HTTPMethod.get, api :NetAPI, suffix:String = "", params:[String:Any]=[:],competion:@escaping Completion) {
        if let isReachable =  reachabilityManager?.isReachable { if isReachable == false { competion(nil, "网络异常!"); return } }
        self.competion = competion
        let url = BASE_URL + api.rawValue + suffix
        Alamofire.request(url, method: method, parameters: params).responseJSON(completionHandler: { responseData in
            switch responseData.result {
            case .success(let json):
                guard let json = json as? [String :Any] else {return competion(nil,"json格式错误!")}
                competion(json,nil)
            case .failure(let error):
                competion(nil,error)
            }
        })
    }
    
}

extension NetworkingTool{
    
    func request(url :String,competion:@escaping Completion) {
        print(url)
        if let isReachable =  reachabilityManager?.isReachable { if isReachable == false { competion(nil, "网络异常!"); return } }
        self.competion = competion
        Alamofire.request(url).responseString { response in
            print(response)
        }
    }
    
}
