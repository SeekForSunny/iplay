//
//  HotRecCellNode.swift
//  iplay
//
//  Created by SMART on 2017/11/30.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HotRecCellNode: ASCellNode {
    private var model:Discuz_Thread
    
    private let avatarNode = ASNetworkImageNode()
    private let authorTextNode = ASTextNode()
    private let levelTextNode = ASTextNode()
    private let fNameTextNode = ASTextNode()
    private let titleTextNode = ASTextNode()
    private var pictureNodes = [ASLayoutElement]()
    private let separatorLineNode = ASDisplayNode()
    
    init(model:Discuz_Thread) {
        self.model = model
        super.init()
        setupChildNodes()
    }
    
    func setupChildNodes(){
        self.automaticallyManagesSubnodes = true
        setupAvatarNode()
        setupAuthorTextNode()
        setupLevelTextNode()
        setupFNameTextNode()
        setupTitleTextNode()
        setupPictureNodes()
        setupSeparatorLineNode()
    }
    
    func setupAvatarNode(){
        let image = model.np ?? ""
        avatarNode.url = URL(string:image)
        avatarNode.style.preferredSize = CGSize(width: 30*APP_SCALE, height: 30*APP_SCALE)
        avatarNode.imageModificationBlock = {image in
            return image.makeConerRadiusImage(radius: 10*APP_SCALE)
        }
    }
    
    func setupAuthorTextNode(){
        let name = model.author ?? ""
        authorTextNode.attributedText = NSAttributedString(string: name, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_14])
    }
    
    func setupLevelTextNode(){
        let level = model.iplayLv ?? 0
        levelTextNode.attributedText = NSAttributedString(string: String.init(describing: " lv\(level) "), attributes: [NSAttributedStringKey.font : SYSTEM_FONT_11,NSAttributedStringKey.foregroundColor:UIColor.blue])
        levelTextNode.borderColor = UIColor.blue.cgColor
        levelTextNode.borderWidth = 0.5
        levelTextNode.cornerRadius = 5*APP_SCALE
    }
    
    func setupFNameTextNode(){
        let fName =  model.fname  ?? ""
        fNameTextNode.attributedText = NSAttributedString(string: " " + fName + " ", attributes: [NSAttributedStringKey.font : SYSTEM_FONT_11,NSAttributedStringKey.foregroundColor:UIColor.white])
        guard  let fidColor =  model.fidColor else {  return }
        if let color = UIColor.hexColor(hex: "#" + fidColor) {
            fNameTextNode.backgroundColor = color
        }
    }
    
    func setupTitleTextNode(){
        let title = model.title ?? ""
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_15])
        titleTextNode.style.width = ASDimensionMake(SCREEN_WIDTH - 2*SM_MRAGIN_15)
    }
    
    func setupPictureNodes(){
        
        var images = [String]()
        if let image = model.imgUrl {
            if image.count > 0{
                images.append(image)
            }
        }
        
        if let image = model.img2Url {
            if image.count > 0{
                images.append(image)
            }
        }
        
        if let image = model.img3Url {
            if image.count > 0{
                images.append(image)
            }
        }
        
        let width = (SCREEN_WIDTH - CGFloat(2*SM_MRAGIN_15) - CGFloat(images.count-1)*SM_MRAGIN_5)/CGFloat(images.count)
        let height = (images.count == 1) ? 150*APP_SCALE : ((images.count == 3) ? 100*APP_SCALE : 120*APP_SCALE)
        let itemSize = CGSize(width: width, height: height)
        for image in images {
            let picNode = ASNetworkImageNode()
            picNode.url = URL(string:image)
            picNode.style.preferredSize = itemSize
            pictureNodes.append(picNode)
        }
    }
    
    func setupSeparatorLineNode(){
        separatorLineNode.backgroundColor = BACK_GROUND_COLOR
        separatorLineNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: SM_MRAGIN_3)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let levelFNameSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [levelTextNode,fNameTextNode])
        levelFNameSpec.style.width = ASDimensionMake(SCREEN_WIDTH - 2*SM_MRAGIN_15 - 30*APP_SCALE - SM_MRAGIN_5)
        
        let authorLevelSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_3, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [authorTextNode,levelFNameSpec])
        
        let topSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_5, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [avatarNode,authorLevelSpec])
        topSpec.style.width = ASDimensionMake(SCREEN_WIDTH - 2*SM_MRAGIN_15)
        
        let picSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_5, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.center, children:pictureNodes)
        let picInsets = UIEdgeInsets(top: SM_MRAGIN_15, left: 0, bottom: SM_MRAGIN_30, right: 0)
        let picInsetSpec = ASInsetLayoutSpec(insets: picInsets, child: picSpec)
        
        let contentStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.start
            , alignItems: ASStackLayoutAlignItems.stretch, children: [topSpec,titleTextNode,picInsetSpec])
        
        let insets = UIEdgeInsets(top: SM_MRAGIN_15, left: SM_MRAGIN_15, bottom: SM_MRAGIN_10, right: SM_MRAGIN_15)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [insetSpec,separatorLineNode])
        return stack
        
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = UIColor.white
    }
    
}
