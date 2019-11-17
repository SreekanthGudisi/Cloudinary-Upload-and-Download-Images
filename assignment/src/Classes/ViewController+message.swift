//
//  ViewController+message.swift
//  assignment
//
//  Created by I0006 on 14/11/19.
//  Copyright © 2019 I0006. All rights reserved.
//



import Foundation
import UIKit

extension ViewController {

    func showMessage(_ text: String) {
        messageLabel.text = text
        messageLabel.isHidden = false

    }

    func hideMessage() {
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.dismissMessage), userInfo: nil, repeats: false)
    }

    @objc fileprivate func dismissMessage(){
        if messageLabel != nil { // Dismiss the view from here
            messageLabel.text = ""
            messageLabel.isHidden = true
        }
    }
}

extension NextViewController {

    func showMessage(_ text: String) {
        messageLabel.text = text
        messageLabel.isHidden = false

    }

    func hideMessage() {
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.dismissMessage), userInfo: nil, repeats: false)
    }

    @objc fileprivate func dismissMessage(){
        if messageLabel != nil { // Dismiss the view from here
            messageLabel.text = ""
            messageLabel.isHidden = true
        }
    }
}
