//
//  ViewController.swift
//  Urbit
//
//  Created by Daniel Clelland on 19/10/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import WebKit

class ViewController: NSViewController {
    
    @IBOutlet var webView: WKWebView!
    
    @IBOutlet var refreshButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh(nil)
    }

    @IBAction func refresh(_ sender: Any?) {
        webView.load(URLRequest(url: URL(string: "http://localhost:8080/")!))
    }

}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webView:didStartProvisionalNavigation:")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("webView:didReceiveServerRedirectForProvisionalNavigation:")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("webView:didFailProvisionalNavigation:", error)
        _ = NSAlert(error: error).runModal()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webView:didCommit:")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView:didFinish:")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("webView:didFail:", error)
        _ = NSAlert(error: error).runModal()
    }
    
}
