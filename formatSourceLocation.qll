import javascript 

string formatSourceLocation(ASTNode ast) {
    result = ast.getLocation().getStartLine() + " " 
            + ast.getLocation().getStartColumn() + " "
            + ast.getLocation().getEndLine() + " "
            + ast.getLocation().getEndColumn() + " "
            + ast.getFile()
}

string formatSourceLocationDataFlow(DataFlow::Node ast) {
    result = ast.getAstNode().getLocation().getStartLine() + " " 
            + ast.getAstNode().getLocation().getStartColumn() + " "
            + ast.getAstNode().getLocation().getEndLine() + " "
            + ast.getAstNode().getLocation().getEndColumn() + " "
            + ast.getAstNode().getFile()
}