//
//  Question.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation

struct Question: Decodable {
    let id: String
    let title: String
    let answers: [QuestionAnswer]
}

struct QuestionAnswer: Decodable {
    let id: String
    let title: String
    let extrovertyScale: Int
}

extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.id == rhs.id
    }
}
