import javascript

// Matches async functions which have no awaits.
// e.g.,
// async function foo() {
//   return 2;
// }
predicate asyncFunctionHasNoAwaits(Function f) {
    f.isAsync() and
    not exists(AwaitExpr ae | ae.getParent*() = f)
}