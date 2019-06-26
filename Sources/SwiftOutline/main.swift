import Foundation
import Commander
import SwiftOutlineKit

let main = command(
    VariadicOption<String>("dir", default: ["."], description: "Target sources directory"),
    VariadicOption<String>("exclude", default: ["Debug"], description: "Keyword to exclude target source path"),
    Option<String>("output", default: "/tmp/graph.png", description: "Graph image file output path"),
    Option<String>("dotfile", default: "/tmp/graph.dot", description: "Intermediate .dot file output path")
) { (dirs, excludes, outputPath, dotfilePath) in
    print("dirs: \(dirs)")
    print("excludes: \(excludes)")
    print("dotfile: \(dotfilePath)")
    print("output: \(outputPath)")

    Emitter().execute(rootDirs: dirs, excludes: excludes, dotfilePath: dotfilePath, outputPath: outputPath)
}
main.run("0.0.3")


