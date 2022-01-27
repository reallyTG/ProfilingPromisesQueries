import javascript
import findAwaitInLoop
import formatSourceLocation

from LoopStmt loop
where loopHasAwait(loop)
// select "pattern7 " + formatSourceLocation(loop)
select "awaitInLoop " + formatSourceLocation(loop)
