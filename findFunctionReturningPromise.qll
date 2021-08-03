import javascript
import findInHousePromisification

// If a function returns a promise, it could instead be made async.
// Note: We probably don't want this anti-pattern, as it requires significant refactoring.
predicate functionReturnsPromise (Function f) {
    ((NewExpr) f.getAReturnedExpr()).getCalleeName() = "Promise" and
    not isInHousePromisification(f)
}