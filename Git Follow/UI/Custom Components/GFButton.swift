//
//  GFButton.swift
//  Git Follow
//
//  Created by iOS Dev on 11/12/25.
//



import UIKit

class GFButton: UIButton {
    override init(frame: CGRect){
        super.init(frame: frame) // calling the default stuff first
        configure()
    }
    
    /// this intit is called when its called by storyboard initializer...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(backgroundColor: UIColor,title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    /// Our custom code
    private func configure(){
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false // enable the auto layout
    }
    
}
