import javascript
import findAsyncFunctionNoAwait
import formatSourceLocation

from Function f
where asyncFunctionHasNoAwaits(f)
select "pattern10 " + formatSourceLocation(f)