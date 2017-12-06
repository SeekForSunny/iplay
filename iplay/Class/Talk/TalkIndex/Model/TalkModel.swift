//
//  TalkIndexModel.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class TalkListModel: HandyJSON {
    
    var articleTags: String?//"",
    var digest: String?//"",
    var docid: String?//"D4ARSH5900318P1K",
    var fromTopicSource: Bool?//false,
    var gameName: String?//"",
    var id: Int?//96088,
    var imgsrc:[String]?// [  "http://cms-bucket.nosdn.127.net/56209b67bdf6446885b95f74764147b820171128103426.jpeg" ],
    var largeLogoUrl: String?//"https://c.cotton.netease.com/buckets/1cphtp/files/JkiPSWZiAVO.jpeg",
    var lmodify: String?//"2017-11-29 06:33:26",
    var newTopicId: Int?//32,
    var nickname: String?//"熊猫命",
    var penName: String?//"熊猫命",
    var photosetId: String?//"",
    var photosetImgNum: Int?//0,
    var priority: Int?//71,
    var ptime: String?//"2017-11-28 10:32:37",
    var readSeconds: Int?//3,
    var replyCount: Int?//5,
    var role: String?//"爱玩小编",
    var showType: Int?//8,
    var source: String?//"",
    var specialId: String?//"",
    var subtitle: String?//"2007年11月29日",
    var title: String?//"战国BASARA2英雄外传——外传才是本体",
    var topicId: String?//"T1461396257593",
    var topicName: String?//"头条",
    var url: String?//"http://play.163.com/17/1128/10/D4ARSH5900318P1K.html",
    var userId: Int?//26430025,
    var userOrder: Bool?//false
    
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "talk_id"
    }

}


class TopTopicModel: HandyJSON {
    var addToTask: Bool?//false,
    var banner: String?//"",
    var followUserCount: Int?//23559,
    var id: Int?//37,
    var idxpic: String?//"http://img2.cache.netease.com/game/app/Game/blz/bx_list_996_346.png",
    var listImg: String?//"",
    var newIcon: String?//"http://img2.cache.netease.com/game/app/Game/blz/bx_icon_220_220.png",
    var newIconBgImg: String?//"http://img2.cache.netease.com/game/app/Game/blz/bx_detail_1080_480.png",
    var recommendNum: Int?//0,
    var topicDescription: String?//"暴雪粉兴趣大本营",
    var topicIconRectangleUrl: String?//"http://img2.cache.netease.com/game/app/Game/blz/bx_guide_660_419.png",
    var topicId: String?//"T1461396489605",
    var topicName: String?//"暴雪资讯",
    var topicType:Int?// 3,
    var weight: Int?//95
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "topic_id"
    }
}
