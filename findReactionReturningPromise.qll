import javascript

// Matches cases where the function passed to .then or .catch explicitly returns a promise
// (which is inefficient as .then and .catch returns a promise anyway).
predicate reactionReturnsPromise(MethodCallExpr mce) {
    mce.getMethodName() in ["then", "catch"] and
    // First argument is a function v => {}.
    ((
        // Does it return an explicit constructor call?
        ((NewExpr) ((Function) mce.getArgument(0)).getAReturnedExpr()).getCalleeName() = "Promise"
    ) or (
        // Check for .resolve or .reject, or .then and .catch
        ((MethodCallExpr) ((Function) mce.getArgument(0)).getAReturnedExpr()).getMethodName() in ["resolve", "reject", "then", "catch"]
    ))
}