//
//  UserInfoVCViewController.swift
//  Git Follow
//
//  Created by iOS Dev on 14/01/26.
//

import UIKit

class UserInfoVC: UIViewController {
    var userName: String!
    var userInfo: Users? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        doneButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = doneButton
        NetworkManager.shared.getUserInfo(for: userName, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue,
                    buttonTitle: "OK"
                )
            case .success(let user):
                DispatchQueue.main.async {
                    self.userInfo = user
                    print(self.userInfo)
                }
            }
        })
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
