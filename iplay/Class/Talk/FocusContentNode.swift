//
//  FocusContentNode.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

let HEADER_NODE_HEIGHT = 220*APP_SCALE

class FocusContentNode: BaseContentNode {
    
    fileprivate var contentArr = [TalkListModel]()
    fileprivate var topicList = [TopTopicModel]()
    
    fileprivate var headerNode:FocusHeaderNode?
    
    override init() {
        super.init()
        
        //加载网络
        loadData()
        
        //设置子节点
        setupChildNodes()
    }
    
    override func didLoad() {
        super.didLoad()
        self.tableNode.view.separatorStyle = .none
        self.tableNode.contentInset = UIEdgeInsetsMake(STATUS_NAVIGATION_BAR_HEIGHT + HEADER_NODE_HEIGHT, 0, TAB_BAR_HEIGHT, 0)
        self.tableNode.backgroundColor = BACK_GROUND_COLOR
        self.tableNode.allowsSelection = false
    }
    
    func setupHeaderNode(){
        if headerNode != nil {  headerNode?.removeFromSupernode() }
        
        headerNode = FocusHeaderNode(topicList: self.topicList)
        if headerNode != nil {
            headerNode!.frame = CGRect(x: 0, y: -HEADER_NODE_HEIGHT, width: SCREEN_WIDTH, height: HEADER_NODE_HEIGHT)
            self.tableNode.addSubnode(headerNode!)
        }
        
    }
    
}


extension FocusContentNode{
    
    func loadData(){
        //https://i.play.163.com/news/article/attention_article_list/0/20
        let suffix = "\(offset)/\(size)"
        NetworkingTool.shareInstance.request(api: NetAPI.Atention, suffix: suffix) { response, error in
            if error == nil {
                guard let info = response!["info"] as? [String:Any] else { self.hasMore = false; return}
                if let list = info["topTopicList"] as? [[String:Any]] {
                    if let models = [TopTopicModel].deserialize(from: list) as? [TopTopicModel] {
                        self.topicList = models
                        self.setupHeaderNode()
                    }
                }
                
                if let list = info["articleList"] as? [[String:Any]] {
                    guard let models = [TalkListModel].deserialize(from: list) as? [TalkListModel] else { self.hasMore = false; return}
                    self.contentArr = models
                    self.tableNode.reloadData()
                    self.offset += self.size
                }
                
            }else{
                self.hasMore = false
                print(error!)
            }
        }
    }
    
    func loadMore(_ context: ASBatchContext){
        context.beginBatchFetching()
        //https://i.play.163.com/news/article/attention_article_list/0/20
        let suffix = "\(offset)/\(size)"
        NetworkingTool.shareInstance.request(api: NetAPI.Atention, suffix: suffix) { response, error in
            if error == nil {
                context.completeBatchFetching(true)
                guard let info = response!["info"] as? [String:Any] else { self.hasMore = false; return }
                
                guard let list = info["articleList"] as? [[String:Any]] else { self.hasMore = false; return }
                guard let models = [TalkListModel].deserialize(from: list) as? [TalkListModel] else { self.hasMore = false; return }
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
                context.completeBatchFetching(true)
                self.hasMore = false;
                print(error!)
            }
        }
    }
}

extension FocusContentNode{
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = contentArr[indexPath.row]
        let cellNodeBlock = { ()->ASCellNode in
            return FocusListCellNode(model:model)
        }
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.loadMore(context)
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return contentArr.count > 0 &&  hasMore
    }
    
}
