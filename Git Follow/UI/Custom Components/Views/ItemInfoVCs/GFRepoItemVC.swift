//
//  GFRepoItemVC.swift
//  Git Follow
//
//  Created by iOS Dev on 02/03/26.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    private func configureItems() {
        itemInfoViewOne.setItemInfoType(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.setItemInfoType(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        deligate.didTapGithubProfile(for: user)
    }
}
