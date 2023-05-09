//
//  Observable.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation

// Wrapper class that converts variables to observables

class Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
