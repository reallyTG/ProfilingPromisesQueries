import javascript

// This catches (something).resolve().then, which is easily refactorable.
predicate promiseDotResolveDotThen(MethodCallExpr c) {
    c.getMethodName() = "then" and
    c.getReceiver() instanceof MethodCallExpr and
    ((MethodCallExpr) c.getReceiver()).getMethodName() = "resolve"
}
