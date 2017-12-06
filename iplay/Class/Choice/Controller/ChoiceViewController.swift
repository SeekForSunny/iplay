//
//  ChoiceViewController.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ChoiceViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleView()
    }
    
    func setupTitleView(){
        let titleViewFrame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (navigationController?.navigationBar.bounds.height)!)
        let titles = ["最新推荐","精选专栏"]
        let titleStyle = TitleStyle()
        let titleView = TitleView(frame: titleViewFrame, titles: titles, titleStyle: titleStyle)
        navigationItem.titleView = titleView
        self.delegate = titleView
        titleView.delegate = self
    }
    
}

extension ChoiceViewController{
    
    override func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        
        let itemSize = CGSize(width: SCREEN_WIDTH, height: self.node.bounds.height)
        let index = indexPath.item
        if index == 0 {
            let cellNode = RecContentNode()
            cellNode.style.preferredSize = itemSize
            return cellNode
        }else{
            let cellNode = TopicContentNode()
            cellNode.style.preferredSize = itemSize
            return cellNode
        }
        
    }
    
}
