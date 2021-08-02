import javascript

predicate asyncFunctionHasNoAwaits(Function f) {
    f.isAsync() and
    not exists(AwaitExpr ae | ae.getParent*() = f)
}