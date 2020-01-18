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

    @IBAction func refresh(_ sender: Any?) {
        webView.load(URLRequest(url: URL(string: "http://localhost:8080/")!))
    }

}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView:didFinish:", navigation!)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("webView:didFail:", navigation!, error)
        _ = NSAlert(error: error).runModal()
    }
    
}
