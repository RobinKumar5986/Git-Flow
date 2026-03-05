//
//  GFFollowerItemVC.swift
//  Git Follow
//
//  Created by iOS Dev on 02/03/26.
//


import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    private func configureItems() {
        itemInfoViewOne.setItemInfoType(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.setItemInfoType(itemInfoType: .following, withCount: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "Git Followers")
    }
    
    override func actionButtonTapped() {
        deligate.didTapGetFollowers(for: user)
    }
    
}
