//
//  HeadlinesContentNode.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HeadlinesContentNode: BaseContentNode {
    
    fileprivate var contentArr = [TalkListModel]()
    fileprivate var controller:TalkViewController
    init(controller:TalkViewController) {
        self.controller = controller
        super.init()
        
        //设置网络请求
        loadData()
        
    }
    
}

extension HeadlinesContentNode{
    
    func loadData(){
        //关注:https://i.play.163.com/news/article/attention_article_list/0/20
        let suffix = "\(offset)/\(size)"
        NetworkingTool.shareInstance.request(api: NetAPI.TodayFirst, suffix: suffix) { response, error in
            if error == nil {
                if let info = response!["info"] as? [[String:Any]] {
                    if let models = [TalkListModel].deserialize(from: info) as? [TalkListModel]{
                        self.contentArr = models
                        self.offset += models.count
                        self.tableNode.reloadData()
                    }
                }
                
            }else{
                print(error!)
            }
        }
    }
    
    func loadMoreData(_ context: ASBatchContext){
        context.beginBatchFetching()
        let suffix = "\(offset)/\(size)"
        print("offset = ",self.offset)
        NetworkingTool.shareInstance.request(api: NetAPI.TodayFirst, suffix: suffix) { response, error in
            if error == nil {
                context.completeBatchFetching(true)
                guard let info = response!["info"] as? [[String:Any]] else {self.hasMore = false;return}
                guard let models = [TalkListModel].deserialize(from: info) as? [TalkListModel] else {self.hasMore = false;return}
                var indexPaths = [IndexPath]()
                for index in 0..<models.count{
                    let row =  index + self.contentArr.count
                    let indexPath = IndexPath(row:row, section: 0)
                    indexPaths.append(indexPath)
                }
                self.contentArr.append(contentsOf: models)
                self.tableNode.insertRows(at: indexPaths, with: UITableViewRowAnimation.none)
                self.offset += 20
                if models.count == 0{self.hasMore = false;}
            }else{
                print(error!)
                context.completeBatchFetching(true)
            }
        }
    }
}


extension HeadlinesContentNode{
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = self.contentArr[indexPath.row]
        let cellNodeBlock = { ()->ASCellNode in
            return FocusListCellNode(model: model)
        }
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.loadMoreData(context)
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return contentArr.count > 0 && hasMore
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        guard let url = self.contentArr[indexPath.row].url else {return}
        let detailVc = TalkDetailViewController(url: url)
        self.controller.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}
