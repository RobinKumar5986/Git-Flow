//
//  UserInfoVCViewController.swift
//  Git Follow
//
//  Created by iOS Dev on 14/01/26.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    
    func didTapGithubProfile()
    func didTapGetFollowers()
}
class UserInfoVC: UIViewController {
    var userName: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    let dateLable = GFBodyLable(textAlignment: .center)
    
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
//                    print(user as Any)
                    self.addChidVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.addChidVC(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.addChidVC(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                    
                    self.dateLable.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
                    
                }
            }
        })
    }
    
    func layoutUI() {
        itemViews = [headerView,itemViewOne,itemViewTwo,dateLable]
        
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
        
       
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor,constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLable.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor,constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 18)
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

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGithubProfile() {
        //TODO: Show safari view controller
    }

    func didTapGetFollowers() {
        //TODO: need to get the followers for this user
    }
}
