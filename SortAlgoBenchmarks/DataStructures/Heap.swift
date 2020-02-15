//
//  Heap.swift
//  SortAlgoBenchmarks
//
//  Created by Andrew O'Brien on 2/13/20.
//  Copyright © 2020 Andrew O'Brien. All rights reserved.
//

struct Heap<Element: Equatable> {
    fileprivate var elements: [Element] = []
    let areSorted: (Element, Element) -> Bool
    
    init(_ elements: [Element], areSorted: @escaping (Element, Element) -> Bool) {
        self.areSorted = areSorted
        self.elements = elements
        
        guard !elements.isEmpty else {
            return
        }
        
        for index in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
            siftDown(from: index)
        }
    }
    
    func hasLeftChild(_ index: Int) -> Bool {
        return getChildIndices(ofParentAt: index).left < count
    }
    
    func hasRightChild(_ index: Int) -> Bool {
        return getChildIndices(ofParentAt: index).right < count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> Element? {
        return elements.first
    }
    
    // O(1) since arrays allow random access. Better than O(log n) of a binary tree
    func getChildIndices(ofParentAt parentIndex: Int) -> (left: Int, right: Int) {
        let leftIndex = (2 * parentIndex) + 1
        return (leftIndex, leftIndex + 1)
    }
    
    // The .5 left over for the left child is floored by integer division
    func getParentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
    
    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
    mutating func removeRoot() -> Element? {
        guard !isEmpty else {
            return nil
        }

        // swap current root with final leaf
        elements.swapAt(0, count - 1)
        
        // remove original root
        let originalRoot = elements.removeLast()
        
        // sift down from new root
        siftDown(from: 0)
        
        return originalRoot
    }
    
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }
        
        if index == elements.count - 1 {
            return elements.removeLast()
        }
        else {
            elements.swapAt(index, elements.count - 1)
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }
            return elements.removeLast()
        }
    }
    
    // Enforces the heap invariant
    mutating func siftDown(from index: Int) {
        var parentIndex = index
        while true {
            // start each iteration by getting the index's children
            let (leftIndex, rightIndex) = getChildIndices(ofParentAt: parentIndex)
            
            // you may need to swap it with one if its children, so store the child index
            var optionalParentSwapIndex: Int?
            
            if hasLeftChild(parentIndex) && areSorted(elements[leftIndex], elements[parentIndex]) {
                 optionalParentSwapIndex = leftIndex
            }
            
            if hasRightChild(parentIndex) && areSorted(elements[rightIndex], elements[optionalParentSwapIndex ?? parentIndex]) {
                optionalParentSwapIndex = rightIndex
            }
            
            // If parent is already arranged properly with respect to its children, siftDown is complete
            guard let parentSwapIndex = optionalParentSwapIndex else {
                return
            }
            
            elements.swapAt(parentIndex, parentSwapIndex)
            parentIndex = parentSwapIndex
        }
    }
    
    mutating func siftUp(from index: Int) {
        var childIndex = index
        var parentIndex = getParentIndex(ofChildAt: childIndex)
        while childIndex > 0 && areSorted(elements[childIndex], elements[parentIndex]) {
            elements.swapAt(childIndex, parentIndex)
            childIndex = parentIndex
            parentIndex = getParentIndex(ofChildAt: childIndex)
        }
    }
}

extension Array where Element: Equatable {
    
    func isHeap(sortedBy areSorted: @escaping (Element, Element) -> Bool) -> Bool {
        if isEmpty {
            return true
        }
        
        for parentIndex in stride(from: count / 2 - 1, through: 0, by: -1) {
            let parent = self[parentIndex]
            let leftChildIndex = 2 * parentIndex + 1
            if areSorted(self[leftChildIndex], parent) {
                return false
            }
            let rightChildIndex = leftChildIndex + 1
            if rightChildIndex < count && areSorted(self[rightChildIndex], parent) {
                return false
            }
        }
        return true
    }
}
