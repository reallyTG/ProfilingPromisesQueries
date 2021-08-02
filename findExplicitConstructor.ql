import javascript
import findExplicitConstructor
import formatSourceLocation

from NewExpr ne
where explicitPromiseConstructorAntipattern(ne)
select "pattern9 " + formatSourceLocation(ne)