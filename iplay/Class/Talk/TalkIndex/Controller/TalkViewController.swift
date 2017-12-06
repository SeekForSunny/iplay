//
//  TalkViewController.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TalkViewController: BaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置标题栏
        setupTitleView()
    }
    
    //MARK: 设置标题栏
    func setupTitleView(){
        let titleViewFrame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:NAVIGATION_BAR_HEIGHT)
        let titles = ["头条","关注"]
        let titleStyle = TitleStyle()
        let titleView = TitleView(frame: titleViewFrame, titles: titles, titleStyle: titleStyle)
        navigationItem.titleView = titleView
        self.delegate = titleView
        titleView.delegate = self
    }
    
    
}

extension TalkViewController{

    override func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        
        let itemSize = CGSize(width: SCREEN_WIDTH, height: self.node.bounds.height)
        let index = indexPath.item
        if index == 0 {
            let cellNode = HeadlinesContentNode(controller:self)
            cellNode.style.preferredSize = itemSize
            return cellNode
        }else{
            let cellNode = FocusContentNode()
            cellNode.style.preferredSize = itemSize
            return cellNode
        }
        
    }

}

