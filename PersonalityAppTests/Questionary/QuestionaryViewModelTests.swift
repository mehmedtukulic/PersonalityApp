//
//  QuestionaryViewModelTests.swift
//  PersonalityAppTests
//
//  Created by Mehmed Tukulic on 10. 5. 2023..
//

import XCTest
@testable import PersonalityApp

@MainActor
final class QuestionaryViewModelTests: XCTestCase {
    private var sut: QuestionaryViewModel!
    private var repositoryMock: QuestionaryRepositoryMock!

    override func setUp() {
        super.setUp()
        repositoryMock = QuestionaryRepositoryMock()
        sut = QuestionaryViewModel(questionsRepository: repositoryMock)
    }

    func testThatThereAreNoQuestionsInitialy() async {
        await sut.viewDidload()

        XCTAssertNil(sut.currentQuestion.value)
        XCTAssertNil(sut.errorMessage.value)
        XCTAssertEqual(sut.currentQuestionCounter, String())
    }

    func testQuestionsLoad() async {
        repositoryMock.questions = [
            .init(id: "1", title: "First", answers: []),
            .init(id: "2", title: "Second", answers: []),
            .init(id: "3", title: "Third", answers: [])
        ]

        await sut.viewDidload()

        XCTAssertNotNil(sut.currentQuestion.value)
        XCTAssertEqual(sut.currentQuestion.value, repositoryMock.questions.first)
        XCTAssertNil(sut.errorMessage.value)
        XCTAssertEqual(sut.currentQuestionCounter, "1/3")

    }

    func testQuestionaryCompleted() async {
        repositoryMock.questions = [
            .init(id: "1", title: "First", answers: [.init(id: "10", title: "First", extrovertyScale: 1)]),
            .init(id: "2", title: "Second", answers: [.init(id: "11", title: "First", extrovertyScale: 1)]),
            .init(id: "3", title: "Third", answers: [.init(id: "12", title: "First", extrovertyScale: 1)])
        ]
        await sut.viewDidload()

        XCTAssertEqual(sut.questionaryCompleted.value, false)
        sut.answerPicked(index: 0)
        XCTAssertEqual(sut.currentQuestionCounter, "2/3")
        sut.answerPicked(index: 0)
        XCTAssertEqual(sut.currentQuestionCounter, "3/3")
        sut.answerPicked(index: 0)

        XCTAssertEqual(sut.questionaryCompleted.value, true)
        XCTAssertEqual(sut.questionaryResult,  "You are an introvert")
    }

}
