//
//  ForumViewController.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ForumViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏
        setupTitleView()
    }
    
    func setupTitleView(){
        let titleViewFrame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (navigationController?.navigationBar.bounds.height)!)
        let titles = ["热门推荐","爱玩专区"]
        let titleStyle = TitleStyle()
        let titleView = TitleView(frame: titleViewFrame, titles: titles, titleStyle: titleStyle)
        navigationItem.titleView = titleView
        self.delegate = titleView
        titleView.delegate = self
    }
    
}

extension ForumViewController{
    
    override func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let itemSize = CGSize(width: SCREEN_WIDTH, height: self.node.bounds.height)
        let index = indexPath.row
        if index == 0 {
            let cellNode = HotRecContentNode()
            cellNode.style.preferredSize = itemSize
            return cellNode
        }else{
            let cellNode = DiscuzContentNode()
            cellNode.style.preferredSize = itemSize
            return cellNode
        }
    }
    
}
