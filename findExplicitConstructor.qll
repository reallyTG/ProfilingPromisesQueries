import javascript

// predicate explicitPromiseConstructorAntipattern(NewExpr ne) {
//     ne.getCalleeName() = "Promise" and
//     ((Function) ne.getArgument(0)).getNumBodyStmt() < 2 and
//     (((MethodCallExpr) ((Function) ne.getArgument(0)).getBodyStmt(0).getAChildExpr()).getMethodName() = "then" or
//     ((MethodCallExpr) ((Function) ne.getArgument(0)).getBody().getAChildExpr*()).getMethodName() = "then")
// }

predicate explicitPromiseConstructorAntipattern(NewExpr ne) {
    ne.getCalleeName() = "Promise" and
    // Return a new promise:
    (((NewExpr) ((Function) ne.getArgument(0)).getAReturnedExpr()).getCalleeName() = "Promise" or
    // Return has .then:
    ((MethodCallExpr) ((Function) ne.getArgument(0)).getAReturnedExpr().getAChildExpr*()).getMethodName() = "then" or
    // Return has resolve:
    ((MethodCallExpr) ((Function) ne.getArgument(0)).getAReturnedExpr().getAChildExpr*()).getMethodName() = "resolve")
}