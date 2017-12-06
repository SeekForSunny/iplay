//
//  HotRecHeaderNode.swift
//  iplay
//
//  Created by SMART on 2017/12/2.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private class PerRecItemNode: ASDisplayNode {
    
    private let pictureNode = ASNetworkImageNode()
    private let coverNode = ASDisplayNode()
    private let titleTextNode_1 = ASTextNode()
    private let titleTextNode_2 = ASTextNode()
    private var model:Discuz_Focus
    
    init(model:Discuz_Focus) {
        self.model = model
        super.init()
        
        setupPictureNode()
        setupTitleTextNode_1()
        setupTitleTextNode_2()
        setupCoverNode()
        self.automaticallyManagesSubnodes = true
    }
    
    func setupPictureNode(){
        let image = model.img ?? ""
        pictureNode.url = URL(string:image)
        pictureNode.style.preferredSize = self.bounds.size
    }
    
    func setupCoverNode(){
        coverNode.style.preferredSize = self.bounds.size
        coverNode.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    func setupTitleTextNode_1(){
        let text = model.subtitleOne ??  ""
        titleTextNode_1.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font : BOLD_SYSTEM_FONT_12,NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
    func setupTitleTextNode_2(){
        let text = model.subtitleTwo ??  ""
        titleTextNode_2.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font : BOLD_SYSTEM_FONT_12,NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let titleStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.start, children: [titleTextNode_1,titleTextNode_2])
        let relSpec = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.end, sizingOption: [], child: titleStack)
        
        let insets = UIEdgeInsets(top: 0 , left: SM_MRAGIN_15  , bottom: SM_MRAGIN_10, right: SM_MRAGIN_15)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: relSpec)
        
        let overSpec = ASOverlayLayoutSpec(child: coverNode, overlay: insetSpec)
        
        let coverSpec = ASOverlayLayoutSpec(child: pictureNode, overlay: overSpec)
        
        return coverSpec
    }
    
}


class HotRecHeaderNode: ASDisplayNode {
    
    private let scrollNode = ASScrollNode()
    private var itemNodeArr = [ASLayoutElement]()
    private let separatorLineNode = ASDisplayNode()
    
    private let list:[Discuz_Focus]
    
    init(frame:CGRect,list:[Discuz_Focus]) {
        self.list = list
        super.init()
        
        self.frame = frame
        setupChildNodes()
    }
    
    func setupChildNodes(){
        
        setupScrollNode()
        setupItemNodeArr()
        
    }
    
    func setupScrollNode(){
        
        scrollNode.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - SM_MRAGIN_5)
        scrollNode.backgroundColor = UIColor.white
        self.addSubnode(scrollNode)
        
        separatorLineNode.frame = CGRect(x: 0, y: scrollNode.frame.maxY, width: self.bounds.width, height: SM_MRAGIN_3)
        separatorLineNode.backgroundColor = BACK_GROUND_COLOR
        self.addSubnode(separatorLineNode)
        
    }
    
    func setupItemNodeArr(){
        print(scrollNode.frame.height)
        for  (index,item)  in list.enumerated() {
            let itemNode = PerRecItemNode(model:item)
            let itemW = (self.bounds.width - SM_MRAGIN_5)/1.5
            let itemH = itemW*0.5
            let itemX =  SM_MRAGIN_15  + CGFloat(index) * (itemW + SM_MRAGIN_5)
            let itemY = (self.bounds.height - SM_MRAGIN_5 - itemH)*0.5 + SM_MRAGIN_5
            itemNode.frame = CGRect(x: itemX, y: itemY, width: itemW , height: itemH)
            scrollNode.addSubnode(itemNode)
        }
    }
    
    override func didLoad() {
        super.didLoad()
        let count = list.count
        let itemW = (self.bounds.width - SM_MRAGIN_5)/1.5
        let contentW = CGFloat(2) * SM_MRAGIN_15  + CGFloat(count) * itemW +  CGFloat(count-1) * SM_MRAGIN_5
        self.scrollNode.view.contentSize = CGSize(width: contentW, height: 0)
    }
    
}

