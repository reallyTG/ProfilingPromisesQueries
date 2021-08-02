import javascript

predicate newPromiseHasAsyncExecutor(NewExpr ne) {
    ne.getCalleeName() = "Promise" and
    ((Function) ne.getArgument(0)).isAsync()
}