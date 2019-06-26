//
//  GraphvizClient.swift
//  SwiftOutlineKit
//
//  Created by kenmaz on 2019/06/26.
//

import Foundation

struct GraphvizClient {
    
    @discardableResult
    private func shell(_ args: String...) -> Int32 {
        let task = Process()

        var env = task.environment ?? [:]
        let path = env["PATH"] ?? ""
        env["PATH"] = "/usr/local/bin:/usr/bin:/bin:\(path)"
        task.environment = env

        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }

    func generateDotPNG(dotPath: String, outputPath: String) {
        guard shell("which", "dot") == 0 else {
            print("dot command is not found. Please install graphviz.")
            print("  brew install graphviz")
            return
        }
        guard shell("dot", "-Tpng", "-o", outputPath, dotPath) == 0 else {
            print("🔥 Failed to generate PNG file")
            return
        }
        shell("open", outputPath)
    }
}
