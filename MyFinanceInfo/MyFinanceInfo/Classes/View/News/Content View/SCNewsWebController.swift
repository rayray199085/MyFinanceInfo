//
//  SCNewsWebController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 23/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import WebKit
import SVProgressHUD

class SCNewsWebController: UIViewController {
    var urlString: String?
    
    private var webView: WKWebView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
    }
    @objc private func clickBackButton(){
        dismiss(animated: true, completion: nil)
    }
}
private extension SCNewsWebController{
    func setupUI(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", fontSize: 16, target: self, action: #selector(clickBackButton), isBack: true)
    }
    func loadWebView(){
        guard let urlString = urlString,
            let url = URL(string: urlString) else{
            return
        }
        webView.load(URLRequest(url: url))
    }
}
extension SCNewsWebController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}
