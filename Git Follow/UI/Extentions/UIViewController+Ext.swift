//
//  UIViewController+Ext.swift
//  Git Follow
//
//  Created by iOS Dev on 19/12/25.
//

import UIKit

fileprivate var containerView: UIView!

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
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25, animations: {
            containerView.alpha = 0.8
        })
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicatorView.startAnimating()
    }
    
    func dismissLodingView(){
        DispatchQueue.main.async{
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String,in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
