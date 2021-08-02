import javascript

predicate loopHasAwait(LoopStmt loop) {
    exists(AwaitExpr ae | ae.getParent*() = loop)
}