//
//  QuestionaryViewController.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import UIKit

final class QuestionaryViewController: UIViewController {
    @IBOutlet private weak var questionNumberLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var answersCollectionView: UICollectionView!

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private let viewModel = QuestionaryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        setScreen()
        bindViewModel()

        Task {
            await viewModel.viewDidload()
        }
    }

    private func bindViewModel() {
        viewModel.isLoadingQuestions.bind { [weak self] loading in
            guard let self else { return }

            if loading {
                startLoader(on: activityIndicator)
                questionTitleLabel.text = "Loading questions..."
            } else {
                stopLoader(on: activityIndicator)
            }
        }

        viewModel.currentQuestion.bind { [weak self] question in
            guard let self else { return }
            questionNumberLabel.text = viewModel.currentQuestionCounter

            if let question = question {
                questionTitleLabel.text = question.title
                answersCollectionView.reloadData()
            }
        }

        viewModel.questionaryCompleted.bind { [weak self] completed in
            guard let self, completed else { return }
            navigateToResults(with: viewModel.questionaryResult)
        }
    }

    private func setScreen() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = Colors.primaryColor.cgColor
        containerView.layer.cornerRadius = 48
    }

    private func setCollection() {
        answersCollectionView.registerCell(ofType: AnswerCell.self)
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        answersCollectionView.collectionViewLayout = layout
    }

}

// MARK: - Collection view handlers
extension QuestionaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCurrentQuestionAnswersCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: AnswerCell.self, indexPath: indexPath)
        guard let answer = viewModel.getAnswerForIndex(index: indexPath.row) else { preconditionFailure("answer should not be nil") }
        cell.configure(with: answer.title, collectionWidth: collectionView.frame.width)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.answerPicked(index: indexPath.row)
    }
}

// MARK: - Navigations
extension QuestionaryViewController {
    private func navigateToResults(with message: String) {
        let vc = ResultViewController()
        vc.setup(message: message)
        navigationController?.pushViewController(vc, animated: true)
    }
}
