import javascript

predicate promiseDotResolveDotThen(MethodCallExpr c) {
    c.getMethodName() = "then" and
    c.getReceiver() instanceof MethodCallExpr and
    ((MethodCallExpr) c.getReceiver()).getMethodName() = "resolve"
}

from MethodCallExpr c
where promiseDotResolveDotThen(c)
select c as Code, c.getLocation() as Location, c.getFile() as File
