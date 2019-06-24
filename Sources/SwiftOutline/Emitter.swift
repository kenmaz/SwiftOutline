//
//  Emitter.swift
//  SwiftOutline
//
//  Created by kenmaz on 2019/06/24.
//

import Foundation
import SwiftSyntax
import PathKit

final class Emitter {

    func execute(rootDirs: [String], excludes: [String], outputPath: String) {
        var subgraphs:[[(String, String)]] = []
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
            for (caller, callee) in subgraph {
                buffer.append("\t")
                let left = caller
                let right = callee
                buffer.append("\"\(left)\" -> \"\(right)\"")
                buffer.append("\n")
                names.insert(caller)
                names.insert(callee)
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

        let outpath = Path(outputPath)
        try! outpath.write(text.data(using: .utf8)!)
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
