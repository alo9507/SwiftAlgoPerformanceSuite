//
//  PrimTest.swift
//  SortAlgoBenchmarksTests
//
//  Created by Andrew O'Brien on 2/23/20.
//  Copyright © 2020 Andrew O'Brien. All rights reserved.
//

import Foundation
import XCTest

@testable import SortAlgoBenchmarks

final class PrimTestCase: XCTestCase {
    func test_metMinimumSpanningTree() {
        var graph = AdjacencyList<Int>()
        
        let one = graph.addVertex(element: 1)
        let two = graph.addVertex(element: 2)
        let three = graph.addVertex(element: 3)
        let four = graph.addVertex(element: 4)
        let five = graph.addVertex(element: 5)
        let six = graph.addVertex(element: 6)
        
        for edge in [
            // minimum spanning tree edges:
            GraphEdge(source: one, destination: three, weight: 1),
            GraphEdge(source: two, destination: three, weight: 5),
            GraphEdge(source: two, destination: five, weight: 3),
            GraphEdge(source: three, destination: six, weight: 4),
            GraphEdge(source: four, destination: six, weight: 2),
            
            // other edges:
            GraphEdge(source: one, destination: two, weight: 6),
            GraphEdge(source: one, destination: four, weight: 5),
            GraphEdge(source: three, destination: four, weight: 5),
            GraphEdge(source: three, destination: five, weight: 6),
            GraphEdge(source: five, destination: six, weight: 6)
            ] {
                graph.addEdge(edge)
        }
        
        let (cost, minimumSpanningTree) = Prim.getMinimumSpanningTree(for: graph)
        XCTAssertEqual(cost, 15)
        
        // a spanning tree should have V - 1 edges
        // divided by two since the edges are undirected/symmetrical so two edges technically exist between each vertex
        let mstEdgeCount = minimumSpanningTree.sortedEdges.count / 2
        let graphVertexCount = graph.vertices.count
        XCTAssertEqual(graphVertexCount - 1, mstEdgeCount)
        
        XCTAssertEqual(
            "\(minimumSpanningTree)",
            """
        0: 1 -> 3 (1.0)

        1: 2 -> 3 (5.0)
                5 (3.0)

        2: 3 -> 1 (1.0)
                2 (5.0)
                6 (4.0)

        3: 4 -> 6 (2.0)

        4: 5 -> 2 (3.0)

        5: 6 -> 3 (4.0)
                4 (2.0)
        """
        )
    }
}
