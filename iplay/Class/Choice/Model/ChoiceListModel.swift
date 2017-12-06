//
//  ChoiceListModel.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import HandyJSON
class RecListModel: HandyJSON {
    
    var docId: String?//"D4DB2UBO00318QE8",
    var gameName: String?//"业界风云",
    var imgUrl: String?//"http://pic-bucket.nosdn.127.net/photo/0031/2017-11-29/D4DB8FP671570031NOS.jpg",
    var largeLogoUrl: String?//"https://g.fp.ps.netease.com/iplay/file/574e359d5e602741cd402e73dpXSRuE3",
    var nickname: String?//"铁士代诺201",
    var penName: String?//"铁士代诺201",
    var ptime: String?//"2017-11-29 09:36:44",
    var readSeconds:Int?// 8,
    var replyCount: Int?//42,
    var role: String?//"金牌作家",
    var title: String?//"厂商骗氪的六层境界：从花钱变强到爱的奉献",
    var userId: Int?//43879062
    
    required init() { }
}

class TopicListModel: HandyJSON {
    var addToTask: Bool?//false,
    var banner: String?//"",
    var followUserCount: Int?//844,
    var id: Int?//65,
    var idxpic: String?//"http://img2.cache.netease.com/game/app/Column/yxwh_518_300.png",
    var ifOrder: Bool?//false,
    var listImg: String?//"http://img2.cache.netease.com/game/app/Column/yxwh_518_300_5.png",
    var newIcon: String?//"",
    var newIconBgImg: String?//"http://img2.cache.netease.com/game/app/Column/yxwh_518_300.png",
    var recommendNum: Int?//0,
    var topicDescription: String?//"趣味发掘考据，解读游戏艺术",
    var topicIconRectangleUrl: String?//"",
    var topicId: String?//"IT1476772090492",
    var topicName: String?//"游戏文化",
    var topicType: Int?//2,
    var weight: Int?//74
    
    required init() { }
}
