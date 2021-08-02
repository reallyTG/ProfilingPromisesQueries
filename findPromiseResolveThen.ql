import javascript
import findPromiseResolveThen
import formatSourceLocation

from MethodCallExpr c
where promiseDotResolveDotThen(c)
select "pattern2 " + formatSourceLocation(c)
