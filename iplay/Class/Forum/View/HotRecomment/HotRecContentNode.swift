//
//  HotRecContentNode.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

let SCROLL_HEADER_HEIGHT = 150*APP_SCALE
class HotRecContentNode: BaseContentNode {
    
    fileprivate var page = 1
    fileprivate var focusList = [Discuz_Focus]()
    fileprivate var contentArr = [Discuz_Thread]()
    private var headerNode:HotRecHeaderNode?
    
    override init() {
        super.init()
        
        loadData() //加载网络
    }
    
    func setupHeader(){
        if headerNode != nil {
            headerNode?.removeFromSupernode()
        }
        
        let frame = CGRect(x: 0, y: -SCROLL_HEADER_HEIGHT, width: SCREEN_WIDTH, height: SCROLL_HEADER_HEIGHT)
        headerNode = HotRecHeaderNode(frame:frame,list: focusList)
        if headerNode != nil {
            self.tableNode.addSubnode(headerNode!)
        }
        
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = BACK_GROUND_COLOR
        self.tableNode.contentInset.top = STATUS_NAVIGATION_BAR_HEIGHT + SCROLL_HEADER_HEIGHT
    }
    
}

extension HotRecContentNode{
    //https://i.play.163.com/news/discuz/hot_recommend/1/20
    func loadData(){
        let sunffix = String.init(describing: "\(page)/\(size)")
        NetworkingTool.shareInstance.request( api: NetAPI.Discuz, suffix: sunffix) { response,error in
            if error == nil {
                
                guard let info = response!["info"] as? [String:Any] else {return}
                if let list = info["focusList"] as? [[String:Any]]{
                    if let models = [Discuz_Focus].deserialize(from: list) as? [Discuz_Focus] {
                        self.focusList = models
                        self.setupHeader()
                    }
                }
                if let list = info["threadList"] as? [[String:Any]]{
                    if let models = [Discuz_Thread].deserialize(from: list) as? [Discuz_Thread] {
                        self.contentArr = models
                        self.tableNode.reloadData()
                        self.page += 1
                    }
                }
            }else{
                print(error!)
            }
        }
    }
    
    func loadMore(_ context:ASBatchContext){
        context.beginBatchFetching()
        let sunffix = String.init(describing: "\(page)/\(size)")
        NetworkingTool.shareInstance.request( api: NetAPI.Discuz, suffix: sunffix) { response,error in
            if error == nil {
                context.completeBatchFetching(true)
                guard let info = response!["info"] as? [String:Any] else {return}
                if let list = info["threadList"] as? [[String:Any]]{
                    if let models = [Discuz_Thread].deserialize(from: list) as? [Discuz_Thread] {
                        var indexPaths = [IndexPath]()
                        for index in 0..<models.count{
                            let row = self.contentArr.count + index
                            let indexPath = IndexPath(row: row, section: 0)
                            indexPaths.append(indexPath)
                        }
                        self.contentArr.append(contentsOf: models)
                        self.tableNode.insertRows(at: indexPaths, with: UITableViewRowAnimation.none)
                        self.page += 1
                    }
                }
            }else{
                context.completeBatchFetching(true)
                print(error!)
            }
        }
    }
    
}

extension HotRecContentNode{
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = contentArr[indexPath.row]
        let cellNodeBlock = {()->ASCellNode in
            let cellNode = HotRecCellNode(model:model)
            return cellNode
        }
        return cellNodeBlock
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return contentArr.count > 0 && hasMore
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.loadMore(context)
    }
}
