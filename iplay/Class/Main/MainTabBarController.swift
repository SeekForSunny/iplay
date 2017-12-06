//
//  MainTabBarController.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MainTabBarController: ASTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        addChildControllers()
    }
    
}

extension MainTabBarController{
    
    func addChildControllers(){
        
        //资讯
        let talkVc = TalkViewController()
        setupChildController(childController: talkVc, title: "资讯", image: "icon_zx")
        
        //精选
        let choiceVc = ChoiceViewController()
        setupChildController(childController: choiceVc,title: "精选", image: "icon_jx")
        
        //社区
        let forumVc = ForumViewController()
        setupChildController(childController: forumVc,title: "社区", image: "icon_sq")
        
        //我
        let mineVc = MineViewController()
        setupChildController(childController: mineVc,title: "我", image: "icon_w")
    }
    
    func setupChildController(childController:UIViewController,title:String,image:String){
        
        let navigationVc = NavigationController(rootViewController: childController)
        addChildViewController(navigationVc)
        
        navigationVc.tabBarItem.image = UIImage(named: image+"_normal_30x30_")
        navigationVc.tabBarItem.selectedImage = UIImage(named: image+"_pressed_30x30_")
        
        childController.title = title
        
        navigationVc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: SYSTEM_FONT_12,NSAttributedStringKey.foregroundColor:UIColor.darkGray], for: UIControlState.normal)
        
        navigationVc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: SYSTEM_FONT_12,NSAttributedStringKey.foregroundColor:UIColor.red], for: UIControlState.selected)
    }
    
}
