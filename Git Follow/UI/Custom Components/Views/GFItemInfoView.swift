//
//  GFItemInfoView.swift
//  Git Follow
//
//  Created by iOS Dev on 26/02/26.
//

import UIKit

enum ItemInfoType{
    case repos
    case gists
    case followers
    case following
}
class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLable(textAlignment: .left, fontSize: 14)
    let countLable = GFTitleLable(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLable)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLable.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLable.heightAnchor.constraint(equalToConstant: 18)
            
            
        ])
        
    }
    
    func setItemInfoType(itemInfoType: ItemInfoType, withCount count: Int) {
        
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.folder)
            titleLabel.text = "Public Repos"
            break
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gist"
            break
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.heart)
            titleLabel.text = "Followers"
            break
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.person2)
            titleLabel.text = "Following"
            break
        }
        countLable.text = String(count)
    }
}
