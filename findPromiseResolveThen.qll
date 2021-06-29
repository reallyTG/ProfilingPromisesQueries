import javascript

predicate promiseDotResolveDotThen(MethodCallExpr c) {
    c.getMethodName() = "then" and
    c.getReceiver() instanceof MethodCallExpr and
    ((MethodCallExpr) c.getReceiver()).getMethodName() = "resolve"
}

