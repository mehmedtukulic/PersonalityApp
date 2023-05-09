//
//  QuestionaryViewController.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import UIKit

class QuestionaryViewController: UIViewController {

    private let viewModel = QuestionaryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await viewModel.viewDidload()
        }
    }

}
