import javascript
import findFunctionReturningPromise
import formatSourceLocation

from Function f
where functionReturnsPromise(f)
select "pattern5 " + formatSourceLocation(f)