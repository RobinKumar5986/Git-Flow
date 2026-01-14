//
//  GFEmptyStateView.swift
//  Git Follow
//
//  Created by iOS Dev on 14/01/26.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLable(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 200),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor,multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 40)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
