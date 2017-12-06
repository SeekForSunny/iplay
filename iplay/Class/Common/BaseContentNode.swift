//
//  BaseContentNode.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class BaseContentNode: ASCellNode {
    
    var offset = 0
    let size = 20
    var hasMore:Bool = true
    
    let tableNode = ASTableNode()
    
    override init() {
        super.init()
        
        //设置子节点
        setupChildNodes()
    }
    
    func setupChildNodes(){

        self.automaticallyManagesSubnodes = true
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: tableNode)
    }
    
    override func didLoad() {
        super.didLoad()
        tableNode.view.separatorStyle = .none
        tableNode.automaticallyAdjustsContentOffset = false
        tableNode.contentInset = UIEdgeInsetsMake(STATUS_NAVIGATION_BAR_HEIGHT, 0, TAB_BAR_HEIGHT, 0)
        tableNode.backgroundColor = BACK_GROUND_COLOR
    }

}

extension BaseContentNode:ASTableDelegate,ASTableDataSource{

    
}
