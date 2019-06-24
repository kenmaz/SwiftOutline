//
//  Analyzer.swift
//  SwiftOutline
//
//  Created by kenmaz on 2019/05/27.
//

import SwiftSyntax
import Foundation

class Analyzer: SyntaxRewriter {
    
    var classNameStack: [String] = []
    private(set) var results: [(String, String)] = []
    
    func run(source: SourceFileSyntax) {
        let _ = visit(source)
    }
    
    func reset() {
        results = []
    }
    
    override func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
        let className = node.identifier.text
        classNameStack.append(className)
        return super.visit(node)
    }
    
    override func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
        if let iden = node.calledExpression as? IdentifierExprSyntax {
            let callee = iden.identifier.text
            let prefix = callee.prefix(1)
            if prefix.uppercased() == prefix
                && (callee.hasSuffix("ViewController")
                    || (callee != "NavigationController" && callee.hasSuffix("NavigationController"))
                ) {
                if let caller = classNameStack.last {
                    results.append((caller, callee))
                } else {
                    results.append(("unknown", callee))
                }
            }
        }
        return super.visit(node)
    }
    
    override func visitPost(_ node: Syntax) {
        if node is ClassDeclSyntax {
            _ = classNameStack.dropLast()
        }
    }
}

