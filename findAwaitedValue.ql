import javascript
import findAwaitedValue
import formatSourceLocation

from AwaitExpr ae
where not ae instanceof PromiseAwaitExpr
select "pattern3 " + formatSourceLocation(ae)
