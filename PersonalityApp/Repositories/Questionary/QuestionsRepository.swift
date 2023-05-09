//
//  QuestionsRepository.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation

protocol QuestionsRepositoryProtocol {
    func getQuestions() async throws -> [Question]
}

class QuestionsRepository: QuestionsRepositoryProtocol {
    private let apiClient: any APIProtocol

    init(apiClient: any APIProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func getQuestions() async throws -> [Question] {
        let request = QuestionsRequests.getQuestions
        do {
            let response: [Question] = try await apiClient.makeRequest(URLSession.shared, request)
            return response
        } catch {
            throw error
        }
    }
}
