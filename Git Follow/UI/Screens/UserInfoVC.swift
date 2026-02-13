//
//  UserInfoVCViewController.swift
//  Git Follow
//
//  Created by iOS Dev on 14/01/26.
//

import UIKit

class UserInfoVC: UIViewController {
    var userName: String!
    let headerView = UIView()
    
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
        layoutUI()
        
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
                    print(user as Any)
                    self.addChidVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
            }
        })
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.backgroundColor = .systemBackground
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func addChidVC(childVC: UIViewController , to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
