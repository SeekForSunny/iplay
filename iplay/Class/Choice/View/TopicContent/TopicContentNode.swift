//
//  TopicContentNode.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TopicContentNode: BaseContentNode {
   fileprivate var contentArr = [TopicListModel]()
    override init() {
        super.init()
        
        //加载网络
        loadData()
    }
    
}

extension TopicContentNode{
    
    //https://i.play.163.com/news/new_topic/list?topicType=2
    func loadData(){
        NetworkingTool.shareInstance.request( api: NetAPI.NewTopic) { response,error in
            if error == nil{
                guard let info = response!["info"] as? [[String:Any] ] else { return }
                guard let models = [TopicListModel].deserialize(from: info) as? [TopicListModel] else { return }
                self.contentArr = models
                self.tableNode.reloadData()
            }else{
                print(error!)
            }
        }
    }
    
}

extension TopicContentNode{
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock = { ()->ASCellNode in
            let model = self.contentArr[indexPath.row]
            return TopicCellNode(model: (model))
        }
        return cellNodeBlock
    }
    
}
