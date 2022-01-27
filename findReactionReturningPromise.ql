import javascript
import findReactionReturningPromise
import formatSourceLocation

from MethodCallExpr mce
where reactionReturnsPromise(mce)
// select "pattern11 " + formatSourceLocation(mce)
select "reactionReturnsPromise " + formatSourceLocation(mce)
