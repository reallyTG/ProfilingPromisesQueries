import javascript
import findAwaitReturnInAsync
import findPromiseResolveThen
import findAwaitedValue

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
    or
    (isAwaitedValue(ast) and result = "pattern3 " + formatSourceLocation(ast))
}

class AntipatternSuperType extends AST::ValueNode {
    AntipatternSuperType() {
        this instanceof Function or 
        this instanceof MethodCallExpr or
        this instanceof AwaitExpr
    }
}

from AntipatternSuperType f
select relevantPattern(f)