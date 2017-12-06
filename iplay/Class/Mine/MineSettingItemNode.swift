//
//  MineSettingItemNode.swift
//  iplay
//
//  Created by SMART on 2017/11/30.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MineSettingItemNode: ASDisplayNode {
    
    private let pictureNode = ASImageNode()
    private let titleTextNode = ASTextNode()
    
    private var title:String
    private var picName:String
    
    init(title:String,picName:String) {
        self.title = title
        self.picName = picName
        super.init()
        setupChildNodes()
    }
    
    func setupChildNodes(){
        self.automaticallyManagesSubnodes = true
        
        setupPictureNode()
        setupTitleTextNode()
    }
    
    func setupPictureNode(){
        pictureNode.image = UIImage(named:picName)
        pictureNode.style.preferredSize = CGSize(width: 28*APP_SCALE, height: 23*APP_SCALE)
        pictureNode.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    func setupTitleTextNode(){
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_12])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [pictureNode,titleTextNode])
        return stack
    }
    
    override func didLoad() {
        super.didLoad()
        self.borderWidth = 1*APP_SCALE
        self.borderColor = BACK_GROUND_COLOR.cgColor
    }
}
