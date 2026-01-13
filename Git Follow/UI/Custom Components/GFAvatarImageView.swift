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
    func downloadImage(from urlString: String){
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self  = self else { return }
            if let data = data, error == nil {
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        task.resume()
    }
}
