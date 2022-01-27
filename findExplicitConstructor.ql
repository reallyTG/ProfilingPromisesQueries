import javascript
import findExplicitConstructor
import formatSourceLocation

/*
from DataFlow::NewNode ne
where explicitPromiseConstructor(ne)
// select "pattern9 " + formatSourceLocationDataFlow(ne)
select "explicitPromiseConstructor " + formatSourceLocationDataFlow(ne)
*/

from PromiseConstructorNode n
where explicitPromiseConstructor(n)
select "explicitPromiseConstructor " + formatSourceLocationDataFlow(n)