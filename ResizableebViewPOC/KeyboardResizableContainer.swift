//
//  KeyboardResizableContainer.swift
//  ResizableebViewPOC
//
//  Created by Roberto Sartori on 26.3.20.
//  Copyright © 2020 Roberto Sartori. All rights reserved.
//

import Foundation
import UIKit

class KeyboardResizableContainer<T: UIView> {
    var isResizingOnKeyboard: Bool = false
    private var resizableView: T
    private var bottomOffset: NSLayoutConstraint

    init(view: T, in parent: UIView) {
        self.resizableView = view
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false;
        parent.translatesAutoresizingMaskIntoConstraints = false;

        self.bottomOffset = parent.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            parent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            parent.topAnchor.constraint(equalTo: view.topAnchor),
            parent.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.bottomOffset
        ])
        self.resizeOnKeyboard(active: true)
    }

    deinit {
        resizeOnKeyboard(active: false)
    }

    func resizeOnKeyboard(active: Bool) {
        if active {
            // enable
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        } else {
            // disable
            NotificationCenter.default.removeObserver(self)
            animateToConstraint(value: 0, duration: 0)
        }
    }

    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let duration: TimeInterval = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

        if notification.name == UIResponder.keyboardWillHideNotification {
            animateToConstraint(value: 0, duration: duration)
        } else {
            animateToConstraint(value: keyboardScreenEndFrame.height, duration: duration)
        }
    }

    private func animateToConstraint(value: CGFloat, duration: TimeInterval) {
        self.bottomOffset.constant = value
        UIView.animate(withDuration: duration) {
            self.bottomOffset.firstItem?.setNeedsLayout()
        }
    }

}
