//
//  RecContentNode.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class RecContentNode: BaseContentNode {
     fileprivate var contentArr = [RecListModel]()
    override init() {
        super.init()
        
        //加载网络
        loadData()
    }
    
}

extension RecContentNode{
    
    //https://i.play.163.com/news/config/config_recommend_article/list
    func loadData(){
        NetworkingTool.shareInstance.request( api: NetAPI.ReconmentList) { response,error in
            if error == nil{
                guard let info = response!["info"] as? [[String:Any] ] else {return}
                guard let models = [RecListModel].deserialize(from: info) as? [RecListModel] else{ return }
                self.contentArr = models
                self.tableNode.reloadData()
            }else{
                print(error!)
            }
        }
    }
    
}

extension RecContentNode{
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = self.contentArr[indexPath.row]
        let cellNodeBlock = { ()->ASCellNode in
            return RecCellNode(model: (model))
        }
        return cellNodeBlock
    }
    
}
