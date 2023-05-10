//
//  ViewController.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        loadInitialScreen()
    }

    private func loadInitialScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            let vc = StartPersonalityTestViewController()
            self?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}

