//
//  WebView.swift
//  ResizableebViewPOC
//
//  Created by Roberto Sartori on 26.3.20.
//  Copyright © 2020 Roberto Sartori. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ResizableWebViewController: UIViewController {

    enum WebViewType {
        case uiwebview
        case wkwebview
    }

    var url: URL!
    var type: WebViewType!

    @IBOutlet weak var resizeSwitch: UISwitch!
    private var resizableView: UIView!
    private var resizer: KeyboardResizableContainer<UIView>!

    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {

        self.navigationItem.title = "Resize ->"

        switch self.type {
        case .wkwebview:
            let webView = WKWebView()
            webView.load(URLRequest(url: url))
            self.resizableView = webView

        case .uiwebview:
            let webView = UIWebView()
            webView.loadRequest(URLRequest(url: url))
            self.resizableView = webView

        default:
            break
        }

        self.resizer = KeyboardResizableContainer(view: self.resizableView, in: self.container)
    }

    @IBAction func resize(_ sender: UISwitch) {
        resizer.resizeOnKeyboard(active: sender.isOn)
        self.view.endEditing(true)
    }
}
