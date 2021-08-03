import javascript

// Async Executor Antipattern:
//
// The executor function f passed to new Promise(...) is asynchronous when it needn't be.
// e.g.,
// let p = new Promise(async (resolve, reject) => { /* ... */ });
predicate newPromiseHasAsyncExecutor(NewExpr ne) {
    ne.getCalleeName() = "Promise" and
    ((Function) ne.getArgument(0)).isAsync()
}