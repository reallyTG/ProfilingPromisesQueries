import javascript
import findSyncResolve
import formatSourceLocation

from DataFlow::NewNode ne
where isPromiseConstructorWithSyncResolve(ne)
select "promiseConstructorSyncResolve " + formatSourceLocationDataFlow(ne)
// select "pattern8 " + formatSourceLocationDataFlow(ne)
