//
//  TopicCellNode.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TopicCellNode: ASCellNode {
    private var model:TopicListModel
    
    private let pictureNode = ASNetworkImageNode()
    private let titleTextNode = ASTextNode()
    private let subtitleTextNode = ASTextNode()
    private let followCountButton = ASButtonNode()
    private let separatorLineNode = ASDisplayNode()
    
    init(model:TopicListModel) {
        self.model = model
        super.init()
        setupChildNodes()
    }
    
    func setupChildNodes(){
        self.automaticallyManagesSubnodes = true
        
        setupPictureNode()
        setupTitleTextNode()
        setupSubtitleTextNode()
        setupFollowCountButtonNode()
        setupSeparatorLineNode()
    }
    
    func setupPictureNode(){
        let image = model.listImg ?? ""
        pictureNode.url = URL(string:image)
        pictureNode.style.preferredSize = CGSize(width: SCREEN_WIDTH*0.5, height: 109)
    }
    
    func setupTitleTextNode(){
        let text = model.topicName ?? ""
        titleTextNode.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font:SYSTEM_FONT_15])
    }
    
    func setupSubtitleTextNode(){
        let text = model.topicDescription ?? ""
        subtitleTextNode.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font:SYSTEM_FONT_11])
    }
    
    func setupFollowCountButtonNode(){
        let count = model.followUserCount ?? 0
        followCountButton.setImage(UIImage(named:"choice_like_img_12x11_"), for: UIControlState.normal)
        followCountButton.setTitle("\(count)", with: SYSTEM_FONT_11, with: UIColor.darkGray, for: UIControlState.normal)
    }
    
    func setupSeparatorLineNode(){
        separatorLineNode.backgroundColor = BACK_GROUND_COLOR
        separatorLineNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: SM_MRAGIN_10)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let rightSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_15, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [titleTextNode,subtitleTextNode,followCountButton])
        rightSpec.style.width = ASDimensionMake(SCREEN_WIDTH*0.5)
        let insets = UIEdgeInsets(top: SM_MRAGIN_15, left: 0, bottom: SM_MRAGIN_10, right: 0)
        let rightInsetSpec = ASInsetLayoutSpec(insets: insets, child:rightSpec )
        
        let contentStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [pictureNode,rightInsetSpec])
        
        let finalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [contentStack,separatorLineNode])
        
        return finalStack
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = .white
    }
    
}
