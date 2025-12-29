//
//  FollowerListVC.swift
//  Git Follow
//
//  Created by iOS Dev on 16/12/25.
//

import UIKit

class FollowerListVC: UIViewController {
    var userName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(
            for: userName,
            page: 1,
            completion: { result in
                switch(result){
                case .failure(let error):
                    self.presentGFAlertOnMainThread(
                        title: "Something went wrong",
                        message: error.rawValue,
                        buttonTitle: "OK"
                    )
                case .success(let followers):
                    print(followers.count)
                    for follower in followers {
                        print("\(follower.login) - \(follower.avatarUrl)")
                    }
                    
                }
            }
        )
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
