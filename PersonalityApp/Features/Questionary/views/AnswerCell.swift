//
//  AnswerCell.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 10. 5. 2023..
//

import UIKit

class AnswerCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = Colors.primaryColor.withAlphaComponent(0.4)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = String()
    }

    func configure(with title: String, collectionWidth: CGFloat) {
        containerView.widthAnchor.constraint(equalToConstant: collectionWidth).isActive = true
        titleLabel.text = title
    }

}
