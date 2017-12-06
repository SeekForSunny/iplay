//
//  FocusHeaderNode.swift
//  iplay
//
//  Created by SMART on 2017/12/2.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

//MARK: - 话题ItemNode
private class TopicItemNode: ASDisplayNode {
    
    private let pictureNode = ASNetworkImageNode()
    private let titleTextNode = ASTextNode()
    
    private var model:TopTopicModel
    init(model:TopTopicModel) {
        self.model = model
        super.init()
        
        self.automaticallyManagesSubnodes = true
        
        setupPictureNode()
        setupTitleTextNode()
    }
    
    func setupPictureNode(){
        let image = model.newIcon ?? ""
        pictureNode.url = URL(string:image)
        pictureNode.style.preferredSize = CGSize(width: 70*APP_SCALE, height: 70*APP_SCALE)
        pictureNode.imageModificationBlock = {image in
            return image.makeConerRadiusImage(radius: 20*APP_SCALE)
        }
    }
    
    func setupTitleTextNode(){
        let text = model.topicName ??  ""
        titleTextNode.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_12])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [pictureNode,titleTextNode])
        
        return stack
    }
    
}

//MARK: - FocusHeaderNode
class FocusHeaderNode: ASDisplayNode {
    
    private let backImageNode = ASImageNode()
    private  let titleTextNode = ASTextNode()
    private let topicNodes = [ASStackLayoutElement]()
    private let focusButtonNode = ASButtonNode()    
    private var topicNodeArr = [ASLayoutElement]()
    
    private var topicList:[TopTopicModel]
    
    init(topicList:[TopTopicModel]) {
        self.topicList = topicList
        super.init()
        
        setupChildNodes()
    }
    
    func setupChildNodes(){
        
        self.automaticallyManagesSubnodes = true
        
        setupBackImageNode()
        setupTitleTextNode()
        setupTopicNodeArr()
        setupFocusButtonNode()
        
    }
    
    //背景图片
    func setupBackImageNode(){
        backImageNode.style.preferredSize = self.bounds.size
        backImageNode.image = UIImage(named:"news_recommendedGame_bg_375x213_")
    }
    
    //标题
    func setupTitleTextNode(){
        titleTextNode.attributedText = NSAttributedString(string: "关注你在爱玩的第一个专区", attributes: [NSAttributedStringKey.font:SYSTEM_FONT_17])
    }
    
    //话题
    func setupTopicNodeArr(){
        for item in topicList {
            let itemNode = TopicItemNode(model:item)
            itemNode.style.preferredSize = CGSize(width: 100*APP_SCALE, height: 100*APP_SCALE)
            topicNodeArr.append(itemNode)
        }
    }
    
    //开始按钮
    func setupFocusButtonNode(){
        focusButtonNode.setTitle("从这里开始", with: SYSTEM_FONT_14, with: UIColor.white, for: UIControlState.normal)
        focusButtonNode.backgroundColor = UIColor.red
        focusButtonNode.style.preferredSize = CGSize(width: 100*APP_SCALE, height: 30*APP_SCALE)
        focusButtonNode.cornerRadius = 30*APP_SCALE * 0.5
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let topicSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_15, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.center, children:topicNodeArr)
        
        let overLayStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_15, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [titleTextNode,topicSpec,focusButtonNode])
        
        let insets = UIEdgeInsets(top: SM_MRAGIN_20, left: 0, bottom: SM_MRAGIN_10, right: 0)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: overLayStack)
        
        let finalSpec = ASOverlayLayoutSpec(child: backImageNode, overlay: insetSpec)
        return finalSpec
    }
    
}
