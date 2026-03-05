//
//  UserInfoVCViewController.swift
//  Git Follow
//
//  Created by iOS Dev on 14/01/26.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    
    func didTapGithubProfile(for: Users)
    func didTapGetFollowers(for: Users)
}

class UserInfoVC: UIViewController {
    var userName: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    let dateLable = GFBodyLable(textAlignment: .center)
    weak var deligate: FollowerListVCDelegate!
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
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            }
        })
    }
    
    func configureUIElements(with user: Users){
        self.addChidVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        let repoItemVC = GFRepoItemVC(user: user)
        let followersItemVC = GFFollowerItemVC(user: user)
        
        repoItemVC.deligate = self
        followersItemVC.deligate = self
        
        self.addChidVC(childVC: repoItemVC, to: self.itemViewOne)
        self.addChidVC(childVC: followersItemVC, to: self.itemViewTwo)
        
        self.dateLable.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
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
    func didTapGithubProfile(for user: Users) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }

    func didTapGetFollowers(for user: Users) {
        if user.followers == 0 {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers.What a Shame😞.", buttonTitle: "Ok")
            return
        }
        dismiss(animated: true)
        deligate.didRequestFollowers(for: user.login)
    }
}
