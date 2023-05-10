//
//  QuestionaryRepositoryMock.swift
//  PersonalityAppTests
//
//  Created by Mehmed Tukulic on 10. 5. 2023..
//

import Foundation

@testable import PersonalityApp

final class QuestionaryRepositoryMock: QuestionsRepositoryProtocol {
    var questions: [Question] = []

    func getQuestions() async throws -> [Question] {
        return questions
    }
}
