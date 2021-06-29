import javascript
import findAwaitReturnInAsync
import findPromiseResolveThen

string formatSourceLocation(AntipatternSuperType ast) {
    result = ast.getLocation().getStartLine() + " " 
            + ast.getLocation().getStartColumn() + " "
            + ast.getLocation().getEndLine() + " "
            + ast.getLocation().getEndColumn() + " "
            + ast.getFile()
}

string relevantPattern(AntipatternSuperType ast) {
    (asyncWithAwaitReturn(ast) and result = "pattern1 " + formatSourceLocation(ast))
    or 
    (promiseDotResolveDotThen(ast) and result = "pattern2 " + formatSourceLocation(ast))
}

class AntipatternSuperType extends AST::ValueNode {
    AntipatternSuperType() {
        this instanceof Function or this instanceof MethodCallExpr
    }
}

from AntipatternSuperType f
select relevantPattern(f)