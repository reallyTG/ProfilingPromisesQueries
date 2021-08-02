import javascript
import findAwaitReturnInAsync
import formatSourceLocation

from Function f
where asyncWithAwaitReturn(f)
select "pattern1 " + formatSourceLocation(f)