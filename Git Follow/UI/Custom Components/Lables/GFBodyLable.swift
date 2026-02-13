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


class GFBodyTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero, textContainer: nil)
        self.textAlignment = textAlignment
    }

    private func configure() {
        backgroundColor = .clear
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        
        // The "Clickable" Magic
        isEditable = false
        isScrollEnabled = false
        dataDetectorTypes = .link
        
        // Make it look like a Label (remove margins)
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
