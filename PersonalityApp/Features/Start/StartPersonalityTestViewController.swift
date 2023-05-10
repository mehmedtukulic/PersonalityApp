//
//  StartPersonalityTestViewController.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import UIKit

final class StartPersonalityTestViewController: UIViewController {

    @IBOutlet private weak var startButton: PrimaryButton! {
        didSet {
            startButton.setButtonTitle("START PERSONALITY TEST")
        }
    }


    @IBAction func startTestTapped(_ sender: Any) {
        let vc = QuestionaryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
