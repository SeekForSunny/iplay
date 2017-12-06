//
//  BaseViewController.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

protocol ScrollContentDelegate:class {
    func scrollView(scrollView:UIScrollView,didScroll toIndex:Int)
}

class BaseViewController: ASViewController<ASDisplayNode> {
    var titleViewFrame = CGRect.zero
    var titles = [String]()
    var titleStyle = TitleStyle()
    
    let collectionNode:ASCollectionNode
    weak var delegate:ScrollContentDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionNode = ASCollectionNode(collectionViewLayout: layout)
        super.init(node: collectionNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置CollectionNode
        setupCollectionNode()
    }
    
    //MARK:设置CollectionNode
    func setupCollectionNode(){
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.view.isPagingEnabled = true
        collectionNode.backgroundColor = BACK_GROUND_COLOR
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
}

extension BaseViewController:ASCollectionDataSource,ASCollectionDelegate{
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return ASCellNode()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        let index = scrollView.contentOffset.x/SCREEN_WIDTH
        delegate?.scrollView(scrollView: scrollView, didScroll: Int(index))
    }
    
}


extension BaseViewController:TitleViewDelegate{
    
    func titleView(titleView: TitleView, didClick atIndex: Int) {
        let offsetX = CGFloat(atIndex)*SCREEN_WIDTH
        let offset = CGPoint(x: offsetX, y: 0)
        self.collectionNode.setContentOffset(offset, animated: true)
    }
    
}

