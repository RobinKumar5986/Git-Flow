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
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        doneButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
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
    
    func layoutUI() {
        itemViews = [headerView,itemViewOne,itemViewTwo]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        headerView.backgroundColor = .systemBackground
        itemViewOne.backgroundColor = .systemCyan
        itemViewTwo.backgroundColor = .systemMint
        
       
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor,constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
    }
    
    func addChidVC(childVC: UIViewController , to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
