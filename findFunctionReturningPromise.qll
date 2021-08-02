import javascript
import findInHousePromisification

predicate functionReturnsPromise (Function f) {
    ((NewExpr) f.getAReturnedExpr()).getCalleeName() = "Promise" and
    not isInHousePromisification(f)
}