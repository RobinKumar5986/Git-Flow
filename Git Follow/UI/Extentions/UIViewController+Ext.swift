//
//  UIViewController+Ext.swift
//  Git Follow
//
//  Created by iOS Dev on 19/12/25.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVc = GFAlertVcViewController(
                alertTitle: title,
                message: message,
                buttonTitle: buttonTitle
            )
            alertVc.modalPresentationStyle = .overFullScreen
            alertVc.modalTransitionStyle = .crossDissolve
            self.present(alertVc, animated: true, completion: nil)
        }
    }
}
