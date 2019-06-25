import XCTest
import class Foundation.Bundle
@testable import SwiftOutlineKit
import SwiftSyntax
import PathKit

final class SwiftOutlineKitTests: XCTestCase {
    func testInitCall() throws {
        let code = """
            class AAAViewController {
                func openBBB() {
                    let vc = BBBViewController()
                    print(v)
                }
            }
            class BBBViewController {
            }
        """
        let path = Path("/tmp/test.swift")
        try! path.write(code.data(using: .utf8)!)

        let source = try! SyntaxTreeParser.parse(path.url)
        let analyze = Analyzer()
        analyze.run(source: source)
        let result = analyze.results

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0], Analyzer.Call(caller: "AAAViewController", callee: "BBBViewController"))
    }
    func testFactoryCall() throws {
        let code = """
            class AAAViewController {
                func openBBB() {
                    BBBViewController.open()
                }
            }
            class BBBViewController {
                func open() {
                    let vc = BBBViewController()
                    present(vc)
                }
            }
        """
        let path = Path("/tmp/test.swift")
        try! path.write(code.data(using: .utf8)!)

        let source = try! SyntaxTreeParser.parse(path.url)
        let analyze = Analyzer()
        analyze.run(source: source)
        let result = analyze.results

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0], Analyzer.Call(caller: "AAAViewController", callee: "BBBViewController"))
        XCTAssertEqual(result[1], Analyzer.Call(caller: "BBBViewController", callee: "BBBViewController"))
    }
}
