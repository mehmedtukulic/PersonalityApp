//
//  QuestionaryViewController.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import UIKit

final class QuestionaryViewController: UIViewController {
    @IBOutlet private weak var questionNumberLabel: UILabel!
    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var answersCollectionView: UICollectionView!

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private let viewModel = QuestionaryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
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

            questionTitleLabel.text = viewModel.questionaryResult
            questionNumberLabel.isHidden = true
            answersCollectionView.isHidden = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popToRootViewController(animated: true)
            }

        }
    }

    private func setCollection() {
        answersCollectionView.registerCell(ofType: AnswerCell.self)
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
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
        cell.titleLabel.text = answer.title
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.answerPicked(index: indexPath.row)
    }

}

extension QuestionaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: answersCollectionView.frame.width, height: 48)
    }
}
