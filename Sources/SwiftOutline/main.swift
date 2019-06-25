import Foundation
import Commander
import SwiftOutlineKit

let main = command(
    VariadicOption<String>("dir", default: ["."], description: "Target sources directory"),
    VariadicOption<String>("exclude", default: ["Debug"], description: "Keyword to exclude target source path"),
    Option<String>("output", default: "./out.dot", description: ".dot file output path")
) { (dirs, excludes, outputPath) in
    print("dirs: \(dirs)")
    print("excludes: \(excludes)")
    print("output: \(outputPath)")

    Emitter().execute(rootDirs: dirs, excludes: excludes, outputPath: outputPath)
}
main.run("0.0.1")


