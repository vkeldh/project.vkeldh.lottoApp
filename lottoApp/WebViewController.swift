//
//  WebViewController.swift
//  lottoApp
//
//  Created by 파디오 on 14/11/2018.
//  Copyright © 2018 padio. All rights reserved.
//
//
import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate, UIApplicationDelegate, WKNavigationDelegate,WKScriptMessageHandler {
    
    @IBOutlet weak var webViewContainer: UIView!
    
  
    let requestURLString = DataSwift.shared.QrCode
    
    var webView: WKWebView!
    var backButton: UIButton!
    var forwadButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        let userController :WKUserContentController = WKUserContentController()
        userController.add(self, name: "nativeAction_1")
        userController.add(self, name: "nativeAction_2")
        
        webConfiguration.userContentController = userController
        
        
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewContainer.frame.size.height))
        self.webView = WKWebView (frame: customFrame , configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webViewContainer.addSubview(webView)
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor).isActive = true
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        self.openUrl()
        
        createWebControlParts()
    }
    
    func openUrl() {
        let url = URL (string: requestURLString)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    private func createWebControlParts() {
        
        let buttonSize = CGSize(width:40,height:40)
        let offseetUnderBottom:CGFloat = 60
        let yPos = (UIScreen.main.bounds.height - offseetUnderBottom)
        let buttonPadding:CGFloat = 10
        
        let backButtonPos = CGPoint(x:buttonPadding, y:yPos)
        let forwardButtonPos = CGPoint(x:(buttonPadding + buttonSize.width + buttonPadding), y:yPos)
        
        backButton = UIButton(frame: CGRect(origin: backButtonPos, size: buttonSize))
        forwadButton = UIButton(frame: CGRect(origin:forwardButtonPos, size:buttonSize))
        
        backButton.setTitle("<", for: .normal)
        backButton.setTitle("< ", for: .highlighted)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.backgroundColor = UIColor.black.cgColor
        backButton.layer.opacity = 0.6
        backButton.layer.cornerRadius = 5.0
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.isHidden = true
        view.addSubview(backButton)
        
        forwadButton.setTitle(">", for: .normal)
        forwadButton.setTitle(" >", for: .highlighted)
        forwadButton.setTitleColor(.white, for: .normal)
        forwadButton.layer.backgroundColor = UIColor.black.cgColor
        forwadButton.layer.opacity = 0.6
        forwadButton.layer.cornerRadius = 5.0
        forwadButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        forwadButton.isHidden = true
        view.addSubview(forwadButton)
        
    }
    
    @objc private func goBack() {
        webView.goBack()
    }
    
    @objc private func goForward() {
        webView.goForward()
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        backButton.isHidden = (webView.canGoBack) ? false : true
        forwadButton.isHidden = (webView.canGoForward) ? false : true
        
        let param: String = "jsCallTest"
        // Javascript側で実行する関数
        let execJsFunc: String = "test(\"\(param)\");"
        webView.evaluateJavaScript(execJsFunc, completionHandler: { (object, error) -> Void in
            // jsの関数実行結果
            // js側で戻り値を返すこともできる
        })
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "padio nativeAction_1" :
            // 値を受け取るときはこんな感じ。
            guard let body = message.body as? NSDictionary else { NSLog("error body type"); return }
            // do something
            
        case "padio nativeAction_2" : return
            // do something
            
        case "callbackHandler":
            print("padio \(message.body)")
            return
        default:
            NSLog("padio undefined message = %s", message.name)
        }
        
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alertController =
            UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let okAction =
            UIAlertAction(title: "OK", style: .default) { action in
                completionHandler()
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // confirm dialogを表示する
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alertController =
            UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let cancelAction =
            UIAlertAction(title: "Cancel", style: .cancel) { action in
                completionHandler(false)
        }
        
        let okAction =
            UIAlertAction(title: "OK", style: .default) {
                action in completionHandler(true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


