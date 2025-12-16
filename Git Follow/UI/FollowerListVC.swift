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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

}
