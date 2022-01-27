import javascript
import findInHousePromisification
import formatSourceLocation

// from Function f
// where isFSRedefinition(f)
// // select "pattern4 " + formatSourceLocation(f)
// select "inHousePromisification " + formatSourceLocation(f)

/*
from DataFlow::NewNode ne 
where inHousePromisificationNewPromise(ne)
select "inHousePromisification " + formatSourceLocationDataFlow(ne)
*/

from PromiseConstructorNodeWithCall np
where inHousePromisificationNewPromise(np)
select "inHousePromisification " + formatSourceLocationDataFlow(np)