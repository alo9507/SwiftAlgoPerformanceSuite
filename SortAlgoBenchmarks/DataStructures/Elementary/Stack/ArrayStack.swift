//
//  Stack.swift
//  SortAlgoBenchmarks
//
//  Created by Andrew O'Brien on 2/23/20.
//  Copyright © 2020 Andrew O'Brien. All rights reserved.
//

import Foundation

// Push: (amortized) O(1)
// Pop: O(1)
// Count: O(N)
// Space: O(N)

extension ArrayStack where Element: Equatable {
    func contains(_ element: Element) -> Bool {
        return storage.contains { element == $0 }
    }
}

struct ArrayStack<Element> {
    private var storage: [Element] = []
    
    var isEmpty: Bool {
        return storage.isEmpty
    }
    
    var peek: Element? {
        return storage.last
    }
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        return isEmpty ? nil : storage.removeLast()
    }
    
    var count: Int {
        return storage.count
    }
}

extension ArrayStack: CustomStringConvertible {
    var description: String {
        return storage
            .map { "\($0)" }
            .joined(separator: " ")
    }
}

extension ArrayStack where Element == GraphVertex<String> {
    var verticesDescription: String {
        return storage.reversed()
            .map { "\($0.element)" }
            .joined(separator: " ")
    }
}
