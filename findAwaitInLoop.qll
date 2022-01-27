import javascript

// Matches loops which are strongly suspected to loop over arrays
// which contain awaits. In practice, these often await things that are
// being looped over, which is unnecessary.
// e.g.,
// for (let l of L) {
//   await foo(l);
// }
predicate loopHasAwait(LoopStmt loop) {
    // If it's a for-of, or for-in ...
    (loop instanceof ForOfStmt or loop instanceof ForInStmt or
    // ... or it's a normal for loop where the test condition is considering the length or size of something, ...
    ((FieldAccess) ((ForStmt) loop).getTest().getAChildExpr()).getPropertyName() in ["length", "size"]) and
    // and there's an await in the body.
    exists(AwaitExpr ae | ae.getParent*() = loop.getBody()) and
    // and there are no continues, breaks, or returns in the loop
    not exists(ReturnStmt rs | rs.getParent*() = loop) and
    not exists(BreakOrContinueStmt bocs | bocs.getParent*() = loop)
}