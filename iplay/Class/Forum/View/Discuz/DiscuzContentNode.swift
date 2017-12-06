//
//  DiscuzContentNode.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DiscuzContentNode: ASCellNode {
    
    private var contentArr = [Discuz_2_Model]()
    private var collectionNode:ASCollectionNode
    
    override init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets.zero
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 30*APP_SCALE)
        collectionNode = ASCollectionNode(collectionViewLayout: layout)
        super.init()
        
        //加载网络
        loadData()
        setupChildNode()
    }
    
    func setupChildNode(){
        self.addSubnode(collectionNode)
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: collectionNode)
    }
    
    override func didLoad() {
        super.didLoad()
        collectionNode.allowsSelection = false
        collectionNode.contentInset = UIEdgeInsets(top: STATUS_NAVIGATION_BAR_HEIGHT, left: 0, bottom: TAB_BAR_HEIGHT, right: 0)
        collectionNode.registerSupplementaryNode(ofKind: UICollectionElementKindSectionHeader)
        collectionNode.backgroundColor = BACK_GROUND_COLOR
    }
    
}

extension DiscuzContentNode{
    func loadData(){
        ////爱玩社区:https://i.play.163.com/news/discuz/discuz_model_v2/list/center/0
        NetworkingTool.shareInstance.request(api: NetAPI.Discuz_2) { response, error in
            
            if error == nil {
                guard let info = response!["info"] as? [String:Any] else {return}
                guard let discuzList = info["discuzList"] as? [[String:Any]] else {return}
                if let models = [Discuz_2_Model].deserialize(from: discuzList) as? [Discuz_2_Model]{
                    self.contentArr = models
                    self.collectionNode.reloadData()
                }
            }
        }
    }
}

extension DiscuzContentNode:ASCollectionDataSource,ASCollectionDelegate{
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return contentArr.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        let model = contentArr[section]
        return model.detailList?.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        guard let model = contentArr[indexPath.section].detailList?[indexPath.item] else { return ASCellNode() }
        let cellNode = DiscuzCellNode(model: model)
        cellNode.style.preferredSize = CGSize(width: (SCREEN_WIDTH-1)*0.5, height: 80*APP_SCALE)
        cellNode.backgroundColor = UIColor.white
        return cellNode
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        let model = contentArr[indexPath.section].type
        let attributes = [NSAttributedStringKey.font: SYSTEM_FONT_13, NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        let textInsets = UIEdgeInsets(top: SM_MRAGIN_7 , left: SM_MRAGIN_15, bottom: SM_MRAGIN_7, right: 0)
        let textCellNode = ASTextCellNode(attributes: attributes, insets: textInsets)
        textCellNode.text = model?.typeName ?? ""
        return textCellNode;
    }
    
}
