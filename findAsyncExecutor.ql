import javascript
import findAsyncExecutor
import formatSourceLocation

from NewExpr ne
where newPromiseHasAsyncExecutor(ne)
select "pattern6 " + formatSourceLocation(ne)