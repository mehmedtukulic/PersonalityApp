//
//  QuestionaryViewModel.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation

@MainActor
final class QuestionaryViewModel {
    let isLoadingQuestions: Observable<Bool> = Observable(false)
    let currentQuestion: Observable<Question?> = Observable(nil)

    let errorMessage: Observable<String?> = Observable(nil)

    private var questions: [Question] = []

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
}
