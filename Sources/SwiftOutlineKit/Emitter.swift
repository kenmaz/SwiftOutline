//
//  Emitter.swift
//  SwiftOutline
//
//  Created by kenmaz on 2019/06/24.
//

import Foundation
import SwiftSyntax
import PathKit

public final class Emitter {

    public init() {}

    public func execute(rootDirs: [String], excludes: [String], dotfilePath: String, outputPath: String) {
        var subgraphs:[[Analyzer.Call]] = []
        let analyzer = Analyzer()
        for rootDir in rootDirs {
            let files = allSourcePaths(directoryPath: rootDir)
            for file in files {
                if !excludes.filter({ file.contains($0) }).isEmpty {
                    continue
                }
                print("Process.. \(file)")
                let url = URL(fileURLWithPath: file)
                let sourceFile = try! SyntaxTreeParser.parse(url)
                analyzer.run(source: sourceFile)
            }
            subgraphs.append(analyzer.results)
            analyzer.reset()
        }
        var names:Set<String> = Set()
        var buffer: [String] = []
        buffer.append("digraph SwiftOutline {")
        buffer.append("\n")
        buffer.append("graph [rankdir=LR]")
        buffer.append("\n")
        for (i, subgraph) in subgraphs.enumerated() {
            buffer.append("\t")
            buffer.append("subgraph cluster_\(i) {")
            for call in subgraph {
                buffer.append("\t")
                let left = call.caller
                let right = call.callee
                buffer.append("\"\(left)\" -> \"\(right)\"")
                buffer.append("\n")
                names.insert(call.caller)
                names.insert(call.callee)
            }
            buffer.append("}")
            buffer.append("\n")
        }
        for name in names {
            if !name.hasSuffix("Controller") {
                buffer.append("\"\(name)\" [style=\"filled\",fillcolor=black, fontcolor=white];")
                buffer.append("\n")
            }
        }

        buffer.append("}")
        buffer.append("\n")
        let text = buffer.joined()

        let outpath = Path(dotfilePath)
        try! outpath.write(text.data(using: .utf8)!)

        let graphviz = GraphvizClient()
        graphviz.generateDotPNG(dotPath: dotfilePath, outputPath: outputPath)
    }

    private func allSourcePaths(directoryPath: String) -> [String] {
        let absolutePath = Path(directoryPath).absolute()
        do {
            return try absolutePath
                .recursiveChildren()
                .filter({ $0.extension == "swift" })
                .map({ $0.string })
        } catch {
            return []
        }
    }
}
