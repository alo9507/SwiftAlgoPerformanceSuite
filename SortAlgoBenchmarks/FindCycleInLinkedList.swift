//
//  FinCycleInLinkedList.swift
//  SortAlgoBenchmarks
//
//  Created by Andrew O'Brien on 3/6/20.
//  Copyright © 2020 Andrew O'Brien. All rights reserved.
//

import Foundation

/*
 Given the head of a singly LinkedList, write a function to determine if the LL has a cycle or not
 */

func hasCycle(_ head: LinkedListNode<Int>) -> Bool {
    var slowPointer: LinkedListNode<Int>? = head
    var fastPointer: LinkedListNode<Int>? = head
    
    while (fastPointer != nil && fastPointer?.next != nil) {
        slowPointer = slowPointer?.next
        fastPointer = fastPointer?.next?.next
        
        if (slowPointer === fastPointer) {
            return true
        }
    }
    return false
}

/*
 Given the head of a LinkedList with a cycle, find the length of the cycle
 */

func cycleLength(_ slow: LinkedListNode<Int>?) -> Int {
    var current: LinkedListNode<Int>? = slow
    var cycleLength = 0
    
    while true {
        current = current?.next
        cycleLength += 1
        if (current === slow) {
            break
        }
    }
    
    return cycleLength
}

/*
 Given the head of a single linked list
 Reverse the linked list
 */

func inplaceReversalOfLinkedList(_ head: LinkedListNode<Int>) -> LinkedListNode<Int> {
    var current: LinkedListNode<Int>? = head
    var previous: LinkedListNode<Int>? = nil
    
    while current != nil {
        // temporarily store the next node
        var next = current?.next
        
        // reverse the current node
        current?.next = previous
        
        // before we move to the next node, point previous to the current node
        previous = current
        
        // move onto the next node
        current = next
    }
    
    return previous!
}
