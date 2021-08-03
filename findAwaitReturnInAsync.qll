import javascript

// Matches async functions with awaited returns --- This is unnecessary.
predicate asyncFunctionWithAwaitReturn(Function f) {
	f.isAsync() and 
	f.getAReturnedExpr() instanceof AwaitExpr
}

predicate asyncWithAwaitReturn(Function f) {
	asyncFunctionWithAwaitReturn(f)
}
