//
//  GFBodyLable.swift
//  Git Follow
//
//  Created by iOS Dev on 18/12/25.
//

import UIKit

class GFBodyLable: UILabel {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    init(textAlignment: NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    private func configure(){
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
