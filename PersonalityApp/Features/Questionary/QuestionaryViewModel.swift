//
//  QuestionaryViewModel.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation

@MainActor
final class QuestionaryViewModel {
    // MARK: - Public observable variables
    let isLoadingQuestions: Observable<Bool> = Observable(false)
    let currentQuestion: Observable<Question?> = Observable(nil)

    let questionaryCompleted: Observable<Bool> = Observable(false)
    let errorMessage: Observable<String?> = Observable(nil)

    // MARK: - Private variables
    private var questions: [Question] = []
    private var extrovertyCount: Int = .zero
    private let maxExtrovertyPerAnswer = 4

    private let questionsRepository: any QuestionsRepositoryProtocol

    init(questionsRepository: any QuestionsRepositoryProtocol = QuestionsRepository()){
        self.questionsRepository = questionsRepository
    }

    func viewDidload() async {
        await fetchQuestions()
    }

    private func fetchQuestions() async {
        isLoadingQuestions.value = true

        do {
            questions = try await questionsRepository.getQuestions()
            currentQuestion.value = questions.first
            isLoadingQuestions.value = false
        } catch {
            errorMessage.value = error.localizedDescription
            isLoadingQuestions.value = false
        }

    }

    // MARK: - Public variables
    /// Index of the current question based on total questions count
    var currentQuestionCounter: String {
        guard let index = questions.firstIndex(where: { $0 == currentQuestion.value }) else { return String() }
        return "\(index + 1)/\(questions.count)"
    }

    /// Result is calculated based on all answered questions extroverty sum.
    /// If extroverty sum is more than a half of a maximum extroverty available (based on total questions count) result = extrovert, otherwise  result = introvert
    lazy var questionaryResult: String = {
        let maxExtroverty = maxExtrovertyPerAnswer * questions.count

        return extrovertyCount > maxExtroverty/2 ? "You are an extrovert" : "You are an introvert"
    }()
}

    // MARK: - Public methods called from view layer
extension QuestionaryViewModel {

    func getCurrentQuestionAnswersCount() -> Int {
        currentQuestion.value?.answers.count ?? .zero
    }

    func getAnswerForIndex(index: Int) -> QuestionAnswer? {
        currentQuestion.value?.answers[index] ?? nil
    }

    func answerPicked(index: Int) {
        guard let currentQuestion = currentQuestion.value else { return }
        let answer = currentQuestion.answers[index]
        extrovertyCount += answer.extrovertyScale

        if currentQuestion != questions.last {
            guard let currentIndex = questions.firstIndex(of: currentQuestion) else { return }
            self.currentQuestion.value = questions[currentIndex+1]
        } else {
            questionaryCompleted.value = true
        }
    }
}
