//
//  RootViewController.swift
//  ResizableebViewPOC
//
//  Created by Roberto Sartori on 26.3.20.
//  Copyright © 2020 Roberto Sartori. All rights reserved.
//

import UIKit
import WebKit

class RootViewController: UIViewController {

    private var resizedWebView: UIView!
    private var url: URL?

    private enum Segues: String {
        case toWKWebView
        case toUIWebView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func toWKWebView(_ sender: Any) {
        self.view.endEditing(true)
        guard url != nil else {
            return
        }
        self.performSegue(withIdentifier: Segues.toWKWebView.rawValue, sender: nil)
    }

    @IBAction func toUIWebView(_ sender: Any) {
        self.view.endEditing(true)
        guard url != nil else {
            return
        }
        self.performSegue(withIdentifier: Segues.toUIWebView.rawValue, sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! ResizableWebViewController
        destinationVC.url = self.url
        switch segue.identifier {
        case Segues.toWKWebView.rawValue:
            destinationVC.type = .wkwebview
        case Segues.toUIWebView.rawValue:
            destinationVC.type = .uiwebview
        default:
            break
        }
    }

    // MARK: - UITextView events
    @IBAction func didEndEditing(_ sender: UITextField) {
        var url = (sender.text ?? "").lowercased()
        if !url.starts(with: "http://") && !url.starts(with: "https://") {
            url = "https://\(url)"
        }
        self.url = URL(string: url)
    }

}

extension RootViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
