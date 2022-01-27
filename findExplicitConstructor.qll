import javascript

/*

    Matches cases where the resolve or reject functions from an outer promise's executor
    are called in an inner asynchronous context.
    
    In the simplest terms:

    new Promise((res, rej) => {
        ...
        someOtherPromise.then(v => {
            res(v);
        }).catch(e => {
            rej(e);
        });
        ...
    });

    The resolve (res) or reject (rej) for the outer promise are
    invoked in an inner promise. 

*/

/*
predicate explicitPromiseConstructor(DataFlow::NewNode n) {
    n.getCalleeName() = "Promise" and
    // Callback passed to .then calls resolve, 
    //  or to .catch calls reject, 
    //  or either appear in new Promise:
    // i.e., there exists a call node cn s.t.
    // cn is enclosed in the outer call n to new Promise
    exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = n.getAstNode() and 
        // cn is also enclosed in a call to then, which itself is enclosed in n
        (exists(MethodCallExpr mce | mce.getMethodName() = "then" and 
                                    cn.getAstNode().getParent*() = mce and
                                    mce.getParent*() = n.getAstNode()) and
        // cn is a call to resolve from n's executor
        cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) n.getArgument(0)).getParameter(0)
        // *and* there is no intermediate function, i.e., no callbacks between resolve and then.
    ) or (
        // cn is in a catch, and it's a call to reject
        exists(MethodCallExpr mce | mce.getMethodName() = "catch" and 
                                    cn.getAstNode().getParent*() = mce and
                                    mce.getParent*() = n.getAstNode()) and
        // cn is a call to reject from n's executor
        cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) n.getArgument(0)).getParameter(1)
    ) or (
        // cn is in an inner new Promise, and is a call to resolve or reject from the outer promise
        exists(NewExpr ne | ne.getCalleeName() = "Promise" and
                            cn.getAstNode().getParent*() = ne and
                            ne.getParent*() = n.getAstNode() and 
                            not ne = n.getAstNode()) and
        (cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) n.getArgument(0)).getParameter(1) or
        cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) n.getArgument(0)).getParameter(0))
    ))
}
*/

/*

    Matches cases where the resolve or reject functions from an outer promise's executor
    are called in an inner asynchronous context.
   
    In the simplest terms:

    new Promise((res, rej) => {
        ...
        someOtherPromise.then(v => {
            res(v);
        }).catch(e => {
            rej(e);
        });
        ...
    });

    The resolve (res) or reject (rej) for the outer promise are
    invoked in an inner promise.

*/

bindingset[fctName]
predicate callInMCNNamed(string fctName, DataFlow::CallNode cn, int paramPosition, PromiseConstructorNode n) {
  exists(DataFlow::MethodCallNode mce | mce.getMethodName() = fctName and
                                    cn.asExpr().getParent*() = mce.asExpr() and
                                    mce.asExpr().getParent*() = n.asExpr()) and
        // cn is a call to resolve from n's executor
        cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) n.getArgument(0)).getParameter(paramPosition)
}

predicate callInInnerPromise(DataFlow::CallNode cn, PromiseConstructorNode n) {
  exists(DataFlow::NewNode ne | ne.getCalleeName() = "Promise" and
                            cn.asExpr().getParent*() = ne.asExpr() and
                            ne.asExpr().getParent*() = n.asExpr() and
                            not ne = n) and
        (cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) n.getArgument(0)).getParameter(1) or
        cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) n.getArgument(0)).getParameter(0))
}

class PromiseConstructorNode extends DataFlow::NewNode {
  PromiseConstructorNode() {
    this.getCalleeName() = "Promise"  
  }
}

predicate explicitPromiseConstructor(PromiseConstructorNode n) {
    // Callback passed to .then calls resolve,
    //  or to .catch calls reject,
    //  or either appear in new Promise:
    // i.e., there exists a call node cn s.t.
    // cn is enclosed in the outer call n to new Promise
    exists(DataFlow::CallNode cn | cn.asExpr().getParent*() = n.asExpr() and
        // cn is also enclosed in a call to then, which itself is enclosed in n
        callInMCNNamed("then", cn, 0, n)
        // *and* there is no intermediate function, i.e., no callbacks between resolve and then.
     or
        // cn is in a catch, and it's a call to reject
        callInMCNNamed("catch", cn, 1, n)
     or
        // cn is in an inner new Promise, and is a call to resolve or reject from the outer promise
        callInInnerPromise(cn, n)
    )
}