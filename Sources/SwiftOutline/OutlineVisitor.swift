//
//  OutlineVisitor.swift
//  SwiftOutline
//
//  Created by kenmaz on 2019/05/28.
//

import Foundation
import SwiftSyntax

class OutlineVisitor: SyntaxVisitor {
    override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        return .visitChildren
    }
    override func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
        return .visitChildren
    }
    override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        return .visitChildren
    }
}
