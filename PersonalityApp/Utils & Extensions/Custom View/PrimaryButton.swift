//
//  PrimaryButton.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 10. 5. 2023..
//

import UIKit

class PrimaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder )
        setupButton()
    }

    func setupButton() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Fonts.bodyBold(size: 21)
        backgroundColor = Colors.primaryColor
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24)
        layer.cornerRadius = 8
    }
    
    func setButtonTitle(_ title: String){
        setTitle(title, for: .normal)
    }
}
