//
//  ResultViewController.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 10. 5. 2023..
//

import UIKit

final class ResultViewController: UIViewController {
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var startAgainButton: PrimaryButton! {
        didSet {
            startAgainButton.setButtonTitle("START AGAIN")
        }
    }

    private var resultMessage = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = resultMessage
    }

    func setup(message: String) {
        resultMessage = message
    }

    @IBAction func startAgainTapped(_ sender: Any) {
        let vc = QuestionaryViewController()
        navigationController?.setViewControllers([vc], animated: true)
    }

}
