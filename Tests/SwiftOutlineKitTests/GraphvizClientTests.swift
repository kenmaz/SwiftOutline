//
//  GraphvizClientTests.swift
//  SwiftOutlineKitTests
//
//  Created by kenmaz on 2019/06/26.
//

import XCTest
@testable import SwiftOutlineKit
import PathKit

class GraphvizClientTests: XCTestCase {

    func test() {
        let code = """
            digraph SwiftOutline {
                graph [rankdir=LR]
                subgraph cluster_0 {
                    "FooViewController" -> "BarViewController"
                    "FooViewController" -> "ZooViewController"
                }
            }
        """
        let dotFile = Path("/tmp/out.dot")
        try! dotFile.write(code.data(using: .utf8)!)
        let outputPath = "/tmp/out.png"

        let client = GraphvizClient()
        client.generateDotPNG(dotPath: dotFile.string, outputPath: outputPath)

    }
}
