//
//  RecCellNode.swift
//  iplay
//
//  Created by SMART on 2017/11/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class RecCellNode: ASCellNode {
    
    private let pictureNode = ASNetworkImageNode()
    private let titleTextNode = ASTextNode()
    private let gameNameTextNode = ASTextNode()
    private let avatarNode = ASNetworkImageNode()
    private let nickNameTextNode = ASTextNode()
    private let roleTextNode = ASTextNode()
    private let replyCountButtonNode = ASButtonNode()
    private let readSecondsButtonNode = ASButtonNode()
    private let separatorLineNode = ASDisplayNode()
    
    private var model:RecListModel
    init(model:RecListModel) {
        self.model = model
        super.init()
        
        setupChildNodes()
    }
    
    func setupChildNodes(){
        
        self.automaticallyManagesSubnodes = true
        
        setupPictureNode()
        setupTitleTextNode()
        setupGameNameTextNode()
        setupAvatarNode()
        setupNickNameTextNode()
        setupRoleTextNode()
        setupReplayCountButtonNode()
        setupReadSecondsButtonNode()
        setupSeparatorLineNode()
        
    }
    
    func setupPictureNode(){
        let image = model.imgUrl ?? ""
        pictureNode.url = URL(string:image)
        pictureNode.style.preferredSize = CGSize(width: SCREEN_WIDTH - CGFloat(2)*SM_MRAGIN_10, height: 170*APP_SCALE)
    }
    
    func setupTitleTextNode(){
        let title = model.title ?? ""
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_17,NSAttributedStringKey.foregroundColor:UIColor.white])
        titleTextNode.style.width = ASDimensionMake(230*APP_SCALE)
    }
    
    func setupGameNameTextNode(){
        let gameName = model.gameName ?? ""
        gameNameTextNode.attributedText = NSAttributedString(string: gameName, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_11,NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
    func setupAvatarNode(){
        let image = model.largeLogoUrl ?? ""
        avatarNode.url = URL(string:image)
        avatarNode.style.preferredSize = CGSize(width: 25*APP_SCALE, height: 25*APP_SCALE)
        avatarNode.imageModificationBlock = { image in
            return image.makeConerRadiusImage(radius: 10*APP_SCALE)
        }
    }
    
    func setupNickNameTextNode(){
        let nickName = model.nickname ?? ""
        nickNameTextNode.attributedText = NSAttributedString(string: nickName, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_13,NSAttributedStringKey.foregroundColor:UIColor.black])
    }
    
    func setupRoleTextNode(){
        let role = model.role ?? ""
        roleTextNode.attributedText = NSAttributedString(string: " " + role + " ", attributes: [NSAttributedStringKey.font : SYSTEM_FONT_11,NSAttributedStringKey.foregroundColor:UIColor(r: 255, g: 215, b: 0)])
        roleTextNode.borderColor = UIColor.lightGray.cgColor
        roleTextNode.borderWidth = 0.5
        roleTextNode.cornerRadius = 2
    }
    
    func setupReplayCountButtonNode(){
        let count = model.replyCount ?? 0
        let replyCount = String.init(describing: count)
        replyCountButtonNode.setImage(UIImage(named:"common_talk_12x12_"), for: UIControlState.normal)
        replyCountButtonNode.setTitle(replyCount, with: SYSTEM_FONT_12, with: UIColor.darkGray, for: UIControlState.normal)
    }
    
    func setupReadSecondsButtonNode(){
        let seconds = model.readSeconds ?? 0
        let readSeconds = String.init(describing: seconds) + "分钟"
        readSecondsButtonNode.setTitle(readSeconds, with: SYSTEM_FONT_12, with: UIColor.darkGray, for: UIControlState.normal)
        readSecondsButtonNode.setImage(UIImage(named:"choice_read_img_12x11_"), for: UIControlState.normal)
    }
    
    func setupSeparatorLineNode(){
        separatorLineNode.backgroundColor = BACK_GROUND_COLOR
        separatorLineNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: SM_MRAGIN_10)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let titleGameNameSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_3, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [titleTextNode,gameNameTextNode])
        
        let topSpec = ASCenterLayoutSpec(centeringOptions: ASCenterLayoutSpecCenteringOptions.XY, sizingOptions: [], child: titleGameNameSpec)
        let overSpec = ASOverlayLayoutSpec(child: pictureNode, overlay: topSpec)
        
        let bottomLeftSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_3, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [avatarNode,nickNameTextNode,roleTextNode])
        
        let bottomRightSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [replyCountButtonNode,readSecondsButtonNode])
        
        let bottomSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.center, children: [bottomLeftSpec,bottomRightSpec])
        
        let insets = UIEdgeInsets(top: SM_MRAGIN_15, left: SM_MRAGIN_10, bottom: SM_MRAGIN_10, right: SM_MRAGIN_15)
        let bottomInsetSpec = ASInsetLayoutSpec(insets: insets, child: bottomSpec)
        
        let outInsets = UIEdgeInsets(top: 0, left: SM_MRAGIN_10, bottom: 0, right: SM_MRAGIN_10)
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [overSpec,bottomInsetSpec,separatorLineNode])
        
        let insetSpec = ASInsetLayoutSpec(insets: outInsets, child: stack)
        return insetSpec
        
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = .white
    }
    
}
