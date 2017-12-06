//
//  MineViewController.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private let COL = 3
private let SETTING_ITEM_W = (SCREEN_WIDTH + CGFloat(COL+1)*APP_SCALE)/CGFloat(COL)
private let SETTING_ITEM_H = SETTING_ITEM_W*0.9

class MineViewController: ASViewController<ASDisplayNode> {
    
    private let avatarNode = ASImageNode()
    private let nameTextNode = ASTextNode()
    private let settingButtonNode = ASButtonNode()
    private let signButtonNode = ASButtonNode()
    private let headerNode = ASDisplayNode()
    
    private let backImageNode = ASImageNode()
    private let picImageNode = ASImageNode()
    private let titleTextNode = ASTextNode()
    private let hotImageNode = ASImageNode()
    private let noticeTextNode = ASTextNode()
    private let middelNode = ASDisplayNode()
   private let separatorLineNode = ASDisplayNode()
    
    
    private var settingNodeArr = [ASLayoutElement]()
    private let bottomNode = ASDisplayNode()
    
    private let scrollNode = ASScrollNode()
    init() {
        super.init(node: scrollNode)
        
        setupChildNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChildNodes(){
        setupHeaderNode()
        setupMiddleNode()
        setupBottomNode()
        setupScrollNode()
        setupSeparatorLineNode()
    }
    
    func setupHeaderNode(){
        
        headerNode.backgroundColor = UIColor.red
        headerNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: 150*APP_SCALE)
        
        avatarNode.image = UIImage(named:"mine_main_default_head_80x80_")
        avatarNode.style.preferredSize = CGSize(width: 80*APP_SCALE, height: 80*APP_SCALE)
        
        nameTextNode.attributedText = NSAttributedString(string: "请登录", attributes: [NSAttributedStringKey.font : SYSTEM_FONT_17,NSAttributedStringKey.foregroundColor:UIColor.white])
        
    }
    
    func setupMiddleNode(){
        
        middelNode.backgroundColor = UIColor.white
        middelNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: 80*APP_SCALE)
        
        picImageNode.image = UIImage(named:"icon_welfare_house_45x51_")
        picImageNode.style.preferredSize = CGSize(width: 45*APP_SCALE, height: 51*APP_SCALE)
        
        titleTextNode.attributedText = NSAttributedString(string: "积分福利", attributes: [NSAttributedStringKey.font : SYSTEM_FONT_17,NSAttributedStringKey.foregroundColor:UIColor.darkGray])
        
        hotImageNode.image = UIImage(named:"img_mineHead_hot_24x22_")
        hotImageNode.style.preferredSize = CGSize(width: 15*APP_SCALE, height: 15*APP_SCALE)
        hotImageNode.contentMode = .scaleAspectFit
        
        let notice = "满满的福利积分商城欢迎你的光临"
        noticeTextNode.attributedText = NSAttributedString(string: notice, attributes: [NSAttributedStringKey.font : SYSTEM_FONT_11,NSAttributedStringKey.foregroundColor:UIColor.gray])
        
    }
    
    func setupSeparatorLineNode(){
        separatorLineNode.backgroundColor = BACK_GROUND_COLOR
        separatorLineNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: SM_MRAGIN_5)
    }
    
    func setupBottomNode(){
        let titles = ["任务中心","消息提醒","我的收藏","文章跟帖","社区帖子","社区浏览记录","我的集卡"]
        let images = ["icon_task_28x23_","icon_mes_28x23_","icon_like_28x23_","icon_title_28x23_","icon_bbs_28x23_","icon_eye_28x23_","icon_card_28x23_"]
        for (index,title) in titles.enumerated() {
            let x = CGFloat(index%COL)*(SETTING_ITEM_W)-CGFloat(index%COL+1)*APP_SCALE
            let y = CGFloat(index/COL)*SETTING_ITEM_H-CGFloat(index/COL+1)*APP_SCALE
            let settingNode = MineSettingItemNode(title: title, picName: images[index])
            settingNode.frame = CGRect(x: x, y: y, width: SETTING_ITEM_W, height: SETTING_ITEM_H)
            bottomNode.addSubnode(settingNode)
        }
        
        let contentH = CGFloat((titles.count+COL-1)/COL)*(SETTING_ITEM_H);
        bottomNode.backgroundColor = UIColor.white
        bottomNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: contentH)
        
    }
    
    func setupScrollNode(){
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.backgroundColor = UIColor.white
        scrollNode.layoutSpecBlock = { node, constrainedSize in
            
            //header
            let headerSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_15, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [self.avatarNode,self.nameTextNode])
            let headerInsets = UIEdgeInsets(top: SM_MRAGIN_20, left: SM_MRAGIN_15, bottom: 0, right: SM_MRAGIN_15)
            let headerInsetSpec = ASInsetLayoutSpec(insets: headerInsets, child: headerSpec)
            let headerOverSpec = ASOverlayLayoutSpec(child: self.headerNode, overlay: headerInsetSpec)
            
            //middle
            let middleSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_10, justifyContent: .start, alignItems: ASStackLayoutAlignItems.center, children: [self.picImageNode,self.titleTextNode,self.hotImageNode,self.noticeTextNode])
            let middleInsets = UIEdgeInsets(top: 0, left: SM_MRAGIN_15, bottom: 0, right: SM_MRAGIN_15)
            let middleInsetSpec = ASInsetLayoutSpec(insets: middleInsets, child: middleSpec)
            let middleOverSpec = ASOverlayLayoutSpec(child: self.middelNode, overlay: middleInsetSpec)
            
            let stack = ASStackLayoutSpec.vertical()
            stack.children = [headerOverSpec,middleOverSpec,self.separatorLineNode,self.bottomNode]
            stack.justifyContent = .start
            stack.alignItems = .center
            stack.spacing = 0
            return stack
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let minH = SCREEN_HEIGHT
        scrollNode.view.isScrollEnabled =  scrollNode.view.contentSize.height > minH ? true : false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.scrollNode.view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: TAB_BAR_HEIGHT, right: 0)
    }
    
}
