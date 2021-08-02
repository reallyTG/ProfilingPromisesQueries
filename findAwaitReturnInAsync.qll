import javascript

predicate asyncFunctionWithAwaitReturn(Function f) {
	f.isAsync() and 
	f.getAReturnedExpr() instanceof AwaitExpr
}

predicate asyncWithAwaitReturn(Function f) {
	asyncFunctionWithAwaitReturn(f)
}


