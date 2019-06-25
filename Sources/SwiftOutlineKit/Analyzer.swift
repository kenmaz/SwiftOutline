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

    struct Call: Equatable {
        let caller: String
        let callee: String
    }
    private(set) var results: [Call] = []
    
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



    override func visit(_ node: MemberAccessExprSyntax) -> ExprSyntax {
        if let baseName = (node.base as? IdentifierExprSyntax)?.identifier.text, isViewController(callee: baseName) {
            addResult(callee: baseName)
        }
        return super.visit(node)
    }

    override func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
        if let callee = (node.calledExpression as? IdentifierExprSyntax)?.identifier.text, isViewController(callee: callee) {
            addResult(callee: callee)
        }
        return super.visit(node)
    }
    
    override func visitPost(_ node: Syntax) {
        if node is ClassDeclSyntax {
            _ = classNameStack.dropLast()
        }
    }

    private func isViewController(callee: String) -> Bool {
        let prefix = callee.prefix(1)
        return prefix.uppercased() == prefix
            && (callee.hasSuffix("ViewController")
                || (callee != "NavigationController" && callee.hasSuffix("NavigationController")))
    }

    private func addResult(callee: String) {
        let caller = classNameStack.last ?? "unknown"
        results.append(Call(caller: caller, callee: callee))
    }

}

