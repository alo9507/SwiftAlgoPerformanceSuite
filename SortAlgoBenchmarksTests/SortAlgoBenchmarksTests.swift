//
//  SortAlgoBenchmarksTests.swift
//  SortAlgoBenchmarksTests
//
//  Created by Andrew O'Brien on 2/13/20.
//  Copyright © 2020 Andrew O'Brien. All rights reserved.
//

import XCTest
@testable import SortAlgoBenchmarks

class SortAlgoBenchmarksTests: XCTestCase {

    func timeElapsed(_ title:String, operation:()->()) {
        let methodStart = Date()
        operation()
        let methodFinish = Date()
        let executionTime = methodFinish.timeIntervalSince(methodStart)
        let executionTimeInMillis = executionTime * 1000
        print("\(title): \(executionTimeInMillis)")
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testBubbleSort() {
        timeElapsed("Bubble Sort: SORTED") {
            BubbleSort.sort(&TestFixtures.tenThousand_sorted)
        }
        
        timeElapsed("Bubble Sort: RANDOM(1...10000)") {
            BubbleSort.sort(&TestFixtures.tenThousand_random)
        }
    }

    func testInsertionSort() {
        timeElapsed("Insertion Sort: SORTED") {
            InsertionSort.sort(&TestFixtures.tenThousand_sorted)
        }
        
        timeElapsed("Insertion Sort: RANDOM(1...10000)") {
            InsertionSort.sort(&TestFixtures.tenThousand_random)
        }
    }
    
    func testSelectionSort() {
        timeElapsed("Selection Sort: SORTED") {
            SelectionSort.sort(&TestFixtures.tenThousand_sorted)
        }
        
        timeElapsed("Selection Sort: RANDOM(1...10000)") {
            SelectionSort.sort(&TestFixtures.tenThousand_random)
        }
    }
}
