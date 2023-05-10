//
//  Resources.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 10. 5. 2023..
//

import UIKit

struct Colors {
    static let primaryColor = #colorLiteral(red: 0.8626773953, green: 0.7692015171, blue: 0.6751674414, alpha: 1)
}

struct Fonts {
    static func bodyRegular(size: CGFloat = 17) -> UIFont {
        UIFont.systemFont(ofSize: size)
    }

    static func bodyBold(size: CGFloat = 17) -> UIFont{
        UIFont.boldSystemFont(ofSize: size)
    }
}
