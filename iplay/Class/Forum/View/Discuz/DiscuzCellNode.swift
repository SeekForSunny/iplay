//
//  DiscuzCellNode.swift
//  iplay
//
//  Created by SMART on 2017/11/30.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DiscuzCellNode: ASCellNode {
    
    private let pictureNode = ASNetworkImageNode()
    private let modelNameTextNode = ASTextNode()
    private let modelDescTextNode = ASTextNode()
    private let todayPostsTextNode = ASTextNode()
    
    private var model:Discuz_2_Detail
    init(model:Discuz_2_Detail) {
        self.model = model
        super.init()
        
        setupChildNodes()
    }
    
    func setupChildNodes(){
        self.automaticallyManagesSubnodes = true
        
        setupPictureNode()
        setupNameTextNode()
        setupModelDescTextNode()
        setupTodayPostsTextNode()
        
    }
    
    func setupPictureNode(){
        let image = model.bannerUrl ?? ""
        pictureNode.url = URL(string:image)
        pictureNode.style.preferredSize = CGSize(width: 50*APP_SCALE, height: 50*APP_SCALE)
        pictureNode.imageModificationBlock = { image in
            return image.makeCircleImage()
        }
    }
    
    func setupNameTextNode(){
        let text = model.modelName ?? ""
        modelNameTextNode.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_15])
    }
    
    func setupModelDescTextNode(){
        let text = model.modelDesc ?? ""
        modelDescTextNode.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_12,NSAttributedStringKey.foregroundColor:UIColor.gray])
    }
    
    func setupTodayPostsTextNode(){
        let post = model.todayPosts ?? 0
        todayPostsTextNode.attributedText = NSAttributedString(string:"\(post)", attributes: [NSAttributedStringKey.font : SYSTEM_FONT_11,NSAttributedStringKey.foregroundColor:UIColor.red])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let rightTopSepc = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_3, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [modelNameTextNode,todayPostsTextNode])
        
        let rightSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.start, children: [rightTopSepc,modelDescTextNode])
        
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_3, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [pictureNode,rightSpec])
        
        return stack
    }
}
