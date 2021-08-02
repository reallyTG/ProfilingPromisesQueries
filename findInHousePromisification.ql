import javascript
import findInHousePromisification
import formatSourceLocation

from Function f
where isFSRedefinition(f)
select "pattern4 " + formatSourceLocation(ast)