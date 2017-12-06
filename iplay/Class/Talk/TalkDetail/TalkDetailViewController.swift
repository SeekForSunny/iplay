//
//  TalkDetailViewController.swift
//  iplay
//
//  Created by SMART on 2017/12/4.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import WebKit

class TalkDetailViewController: ASViewController<ASDisplayNode> {
    var url:String
    let webView = WKWebView()
    init(url:String) {
        self.url = url
        super.init(node: ASDisplayNode())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIContent()
        
    }
    
    func setupUIContent(){
        
        webView.frame = self.node.bounds
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string:url)!))
        self.node.view .addSubview(webView)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        tapGes.delegate = self
        webView.addGestureRecognizer(tapGes)
        
    }
    
    @objc func tap(_ ges:UITapGestureRecognizer){
        let point = ges.location(in: webView)
        print("document.elementFromPoint(" + "\(point.x)" + ", " + "\(point.y)" + ").href")
        let js = "document.elementFromPoint(" + "\(point.x)" + ", " + "\(point.y)" + ").src"
        webView.evaluateJavaScript(js) { (result, error) in
            if let url = result as? String{
                print(url)
            }
        }
    }
    
}

extension TalkDetailViewController:UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension TalkDetailViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(url)
        let js = "document.getElementsByClassName('m-fixedTop')[0].remove();"
            + "document.getElementsByClassName('m-fixedBot')"
            + "[0].remove();document.getElementById('OpenApp3').remove();"
            + "var length = document.getElementsByClassName('comment-c').length;"
            + "if(length>=5){"
            + "var e=document.createElement(\"input\");"
            + "e.type = \"button\";e.value = \"查看更多\";"
            + "e.setAttribute(\"style\",\"border:0.5px solid red; width:100px; height:30px;color:red;margin:30px " + "\(Int(SCREEN_WIDTH - 100)/2)" + "px;border-radius:15px;\");"
            + "var pare =document.getElementsByClassName('m-comment')[0];"
            + "pare.appendChild(e);"
            + "};"
        
        webView.evaluateJavaScript(js) { (reslut, error) in }
    }
    
}

