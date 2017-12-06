//
//  ForumModel.swift
//  iplay
//
//  Created by SMART on 2017/11/30.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class Discuz_Focus: HandyJSON {
    var id: Int?//81,
    var img: String?//"http://iplay.nosdn.127.net/hpzj2ul6ez5ka76cs2hduvristxe7qdl.jpe",
    var priority:Int?// 141,
    var subtitleOne: String?//"爱玩众测第六弹 回帖赢金士顿键盘",
    var subtitleTwo: String?//"聊双十一剁手经历 赢999机械键盘",
    var tid: String?//"173532015",
    var title: String?//"爱玩众测第六弹 回帖赢金士顿键盘",
    var url: String?//""
    
    required init() {}
}

class Discuz_Thread: HandyJSON {
    var fid: String?//"421",
    var nu: String?//"谜失方向",
    var iplayLv: Int?//6,
    var weight: Int?//1143,
    var img2Url: String?//"http://iplay.nosdn.127.net/fixliwwznl239rdin85u7p3j4f6lyuoo.jpe",
    var np: String?//"http://g.fp.ps.netease.com/iplay/file/58de1e4b143cfacadf8b252fbjCrV8Do",
    var subject: String?//"",
    var digest: String?//"0",
    var roleName: String?//"普通用户",
    var dateline: String?//"1511857491",
    var medalSlots: [Discuz_Thread_MedalSlot]?
    var highlight: String?//"41",
    var author: String?//"谜失方向",
    var title: String?//"剑网三地图竞猜开启！回答正确3个以上即有机会获得激活码",
    var authorid: String?//"1242452",
    var typeid: String?//"1293",
    var fidColor: String?//"f77232",
    var showType: Int?//2,
    var tid: String?//"173548331",
    var fname: String?//"网游专区",
    var img3Url: String?//"",
    var lastposter: String?//"月下轻楼",
    var lastpost: String?//"1511972868",
    var lastposterid: String?//"2241196",
    var iplayExtcredits3: Int?//3285,
    var imgUrl: String?//"http://iplay.nosdn.127.net/6ulg5w6f3cswlxud6vutzgvubcslkp80.jpe",
    var medalSlotNum: Int?//1,
    var groupId: Int?//3,
    var replies: String?//"36",
    var views: String?//"782",
    var urs: String?//"mishi_l@163.com",
    var typename: String?//"活动",
    var subtitle: String?//"",
    var strategyTags: String?//""
    
    required init() { }
}

class Discuz_Thread_MedalSlot: HandyJSON {
    var obtain_url: String?//"",
    var app_image_url: String?//"http://iplay.nosdn.127.net/uzetayhw9ku9qqyld0dxkm97k4kwkl0k.png",
    var obtain_desc: String?//"绝版，停止发放",
    var slot_id: Int?//1,
    var description:String?// "凯恩之角金币纪念勋章：一阶",
    var medal_id: Int?//251,
    var medal_name: String?//"凯恩·感谢有你"
    required init() { }
}


class Discuz_2_Model: HandyJSON {
    
    var type: Discuz_2_Type?
    var detailList: [Discuz_2_Detail]?
    required init(){}
    
}

class Discuz_2_Detail: HandyJSON {
    
    var bannerUrl: String?//"http://img2.cache.netease.com/game/app/bbs/banner/398_new.jpg",
    var discuzModelTypeId: Int?//1,
    var fid: Int?//398,
    var iconUrl: String?//"http://img2.cache.netease.com/game/app/bbs/icon/398_new2.png",
    var modelDesc: String?//"综合游戏讨论区",
    var modelName: String?//"玩家大厅",
    var posts: Int?//90795,
    var recommendList: Int?//1,
    var specialRedirect: Int?//0,
    var threads: Int?//2819,
    var todayPosts: Int?//5,
    var top: Int?//0,
    var weight: Int?//100
    
    required init() { }
}

class Discuz_2_Type: HandyJSON {
    
    var category: Int?//0,
    var id: Int?//1,
    var typeName: String?//"中心广场",
    var weight: Int?//100
    
    required init() { }
}
