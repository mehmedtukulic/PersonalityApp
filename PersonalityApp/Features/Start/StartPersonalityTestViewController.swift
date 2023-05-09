//
//  StartPersonalityTestViewController.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import UIKit

class StartPersonalityTestViewController: UIViewController {

    @IBAction func startTestTapped(_ sender: Any) {
        let vc = QuestionaryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
