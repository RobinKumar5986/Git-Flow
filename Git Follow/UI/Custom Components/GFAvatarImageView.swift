//
//  GFAvatarImageView.swift
//  Git Follow
//
//  Created by iOS Dev on 29/12/25.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeHolderImage = UIImage(named: "avatar-placeholder")!
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
