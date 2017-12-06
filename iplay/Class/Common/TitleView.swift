//
//  TitleView.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit

protocol TitleViewDelegate:class {
    func titleView(titleView:TitleView, didClick atIndex:Int)
}

struct TitleStyle {
    
    var normalColor:UIColor = UIColor.lightGray
    var selectedColor:UIColor = UIColor.black
    var normalSize:CGFloat = 16*APP_SCALE
    var selectedSize:CGFloat = 18*APP_SCALE
    var indicatorWith:CGFloat = 15*APP_SCALE
    var indicatorHeight:CGFloat = 3*APP_SCALE
    var indicatorColor:UIColor = UIColor.red
    
}

class TitleView: UIView {
    
    fileprivate var titles:[String]
    fileprivate var titleStyle:TitleStyle
    fileprivate lazy var titleBtnArr = [UIButton]()
    fileprivate var seletedButton:UIButton?
    fileprivate lazy var indicator:UIView = UIView()
    weak var delegate:TitleViewDelegate?
    
    init(frame: CGRect,titles:[String],titleStyle:TitleStyle) {
        self.titles = titles
        self.titleStyle = titleStyle
        super.init(frame: frame)
        
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TitleView{
    
    func setupUIContent(){
        
        let y:CGFloat = 0
        let width = self.bounds.width/CGFloat(self.titles.count)
        let height = self.bounds.height
        
        for (index,title) in self.titles.enumerated(){
            
            let button = UIButton()
            self.titleBtnArr.append(button)
            button.addTarget(self, action:#selector(self.buttonClicked(_:)), for: UIControlEvents.touchUpInside)
            button.setTitle(title, for: UIControlState.normal)
            button.setTitleColor(self.titleStyle.normalColor, for: UIControlState.normal)
            button.setTitleColor(self.titleStyle.selectedColor, for: UIControlState.selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: self.titleStyle.normalSize)
            button.frame = CGRect(x: CGFloat(index)*width, y: y, width: width, height: height)
            self.addSubview(button)
            
        }
        
        //设置指示器
        self.setupIndicator()
        
    }
    
    func setupIndicator(){
        
        guard let firstButton = self.titleBtnArr.first else {return}
        
        firstButton.titleLabel?.sizeToFit()
        let iX = firstButton.frame.maxX  - firstButton.bounds.width * 0.5 - self.titleStyle.indicatorWith*0.5
        let iY = firstButton.bounds.height - self.titleStyle.indicatorHeight - SM_MRAGIN_5
        self.indicator.backgroundColor = self.titleStyle.indicatorColor
        self.indicator.frame = CGRect(x: iX, y: iY, width: self.titleStyle.indicatorWith, height: self.titleStyle.indicatorHeight)
        self.addSubview(self.indicator)
        
        self.buttonClicked(firstButton)
        
    }
    
    @objc func buttonClicked(_ sender:UIButton){
        
        self.seletedButton?.titleLabel?.font = UIFont.systemFont(ofSize: self.titleStyle.normalSize)
        self.seletedButton?.isSelected = false
        sender.isSelected = true
        self.seletedButton = sender
        sender.titleLabel?.font = UIFont.systemFont(ofSize: self.titleStyle.selectedSize)
        
        UIView.animate(withDuration: 0.25) {
            let iX = sender.frame.maxX  - sender.bounds.width * 0.5 - self.titleStyle.indicatorWith*0.5
            self.indicator.frame.origin.x = iX
        }
        
        guard let index = titleBtnArr.index(of: sender) else { return }
        delegate?.titleView(titleView: self, didClick: index)
        
    }
    
}

extension TitleView:ScrollContentDelegate{
    
    func scrollView(scrollView: UIScrollView, didScroll toIndex: Int) {
        let button = self.titleBtnArr[toIndex]
        self.buttonClicked(button)
    }
    
}
