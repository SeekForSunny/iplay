//
//  FocusListCellNode.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FocusListCellNode: ASCellNode {
    
    private let pictureNode = ASNetworkImageNode()
    private let titleTextNode = ASTextNode()
    private let replyButtonNode = ASButtonNode()
    private let sourceTextNode = ASTextNode()
    private let separatorLineNode = ASDisplayNode()
    
    fileprivate let model:TalkListModel
    init(model:TalkListModel) {
        self.model = model
        super.init()
        
        setupChildNodes()
    }
    
    func setupChildNodes(){
        self.automaticallyManagesSubnodes = true
        
        setupPictureNode()
        setupTitleTextNode()
        setupReplyButtonNode()
        setupSourceTextNode()
        setupSeparatorLineNode()
        
    }
    
    func setupPictureNode(){
        
        guard let showType = model.showType else { return }
        let image = model.imgsrc?.first ?? ""
        pictureNode.url = URL(string:image)
        pictureNode.isLayerBacked = true
        if showType == 2 {
            pictureNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: 180*APP_SCALE)
        }else if showType == 5{
            pictureNode.style.preferredSize = CGSize(width: 130*APP_SCALE, height: 90*APP_SCALE)
        }else { return }
    }
    
    func setupTitleTextNode(){
        
        guard let showType = model.showType else { return }
        let title = model.title ?? ""
        titleTextNode.isLayerBacked = true
        if showType == 2 {
            titleTextNode.attributedText = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_17,NSAttributedStringKey.foregroundColor:UIColor.white])
            titleTextNode.style.width = ASDimensionMake(230*APP_SCALE)
            titleTextNode.maximumNumberOfLines = 0
        }else if showType == 5{
            titleTextNode.attributedText = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_17,NSAttributedStringKey.foregroundColor:UIColor.black])
            titleTextNode.style.width = ASDimensionMake(230*APP_SCALE)
            titleTextNode.maximumNumberOfLines = 2
            
        }else { return }
        
    }
    
    func setupReplyButtonNode(){
        let count = model.replyCount ?? 0
        let replyCount = String.init(describing: count)
        replyButtonNode.setImage(UIImage(named:"common_talk_12x12_"), for: UIControlState.normal)
        replyButtonNode.setTitle(replyCount, with: SYSTEM_FONT_12, with: UIColor.darkGray, for: UIControlState.normal)
    }
    
    func setupSourceTextNode(){
        let gameName = model.gameName ?? ""
        sourceTextNode.isLayerBacked = true
        sourceTextNode.attributedText = NSAttributedString(string: gameName, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_12,NSAttributedStringKey.foregroundColor:UIColor.blue])
    }
    
    func setupSeparatorLineNode(){
        separatorLineNode.isLayerBacked = true
        separatorLineNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: SM_MRAGIN_3)
        separatorLineNode.backgroundColor = BACK_GROUND_COLOR
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        guard let showType = model.showType else { return ASLayoutSpec() }
        if showType == 2 {
            let centerSpec = ASCenterLayoutSpec(centeringOptions: ASCenterLayoutSpecCenteringOptions.XY, sizingOptions: [], child: titleTextNode)
           
            let overSpec = ASOverlayLayoutSpec(child: pictureNode, overlay: centerSpec)
            
            let finalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [overSpec,separatorLineNode])
           
            return finalSpec
        }else if showType == 5{
            
            let bottomSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [replyButtonNode,sourceTextNode])
            
            let leftSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [titleTextNode,bottomSpec])
            let leftInsets = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(SM_MRAGIN_15, SM_MRAGIN_15, SM_MRAGIN_5, 0), child: leftSpec)
            
            let contentSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.stretch, children: [leftInsets,pictureNode])
            
            let finalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [contentSpec,separatorLineNode])
            
            return finalSpec
        }else { return ASLayoutSpec() }
        
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = UIColor.white
    }
    
}
