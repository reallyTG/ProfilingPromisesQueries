import javascript
import findExplicitConstructor
import formatSourceLocation

from DataFlow::NewNode ne
where explicitPromiseConstructor(ne)
select "pattern9 " + formatSourceLocationDataFlow(ne)