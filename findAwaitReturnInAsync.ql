import javascript

predicate asyncFunctionWithAwaitReturn(Function f) {
	/* Is it an async function with a single return statement? */
	f.isAsync() and f.getNumBodyStmt() = 1 and
	/* Is the single return statement an await expression? */
	exists(ReturnStmt r_s | r_s.getContainer() = f and r_s.getExpr() instanceof AwaitExpr)
}

predicate asyncLambdaWithAwaitOnly(Function f) {
	f.isAsync() and f.getNumBodyStmt() = 0 and
	f.getNumChildExpr() = 1 and
	f.getAChildExpr() instanceof AwaitExpr
}

predicate asyncWithAwaitReturn(Function f) {
	asyncFunctionWithAwaitReturn(f) or asyncLambdaWithAwaitOnly(f)
}

from Function f
where asyncWithAwaitReturn(f)
select f as Function, f.getLocation() as Location, f.getFile() as File


