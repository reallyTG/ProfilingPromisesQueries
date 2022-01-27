import javascript

// Calls to the promise constructor where the executor function calls resolve *or* reject synchronously,
// and does not call the other. In this case, the body b of the executor can, roughly, be placed in a 
// Promise.resolve(b) or Promise.reject(b).
predicate isPromiseConstructorWithSyncResolve(DataFlow::NewNode ne) {
    ne.getCalleeName() = "Promise" and
    // For resolve calls and no reject calls:
    ((exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and 
                                     cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(0) and
                                     not exists(CallExpr ce | ce.getCalleeName() = "setTimeout" and
                                                              ce.getParent*() = ne.getAstNode())) and
    not exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(1))) 
    or
    // For reject calls and no resolve calls:
    (exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and 
                                    cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(1) and
                                    not exists(CallExpr ce | ce.getCalleeName() = "setTimeout" and
                                                              ce.getParent*() = ne.getAstNode())) and
    not exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(0))))
}

// import javascript

// // Calls to the promise constructor where the executor function calls resolve *or* reject synchronously,
// // and does not call the other. In this case, the body b of the executor can, roughly, be placed in a 
// // Promise.resolve(b) or Promise.reject(b).
// predicate isPromiseConstructorWithSyncResolve(DataFlow::NewNode ne) {
//     ne.getCalleeName() = "Promise" and
//     // For resolve calls and no reject calls:
//     ((exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and 
//                                      cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(0) and
//                                      not exists(Function f | f.getParent*() = ne.getAstNode() and
//                                                              f.getName() = "setTimeout" and
//                                                              //  not ne.getAnArgument().getAstNode() = f and
//                                                              cn.getAstNode().getParent*() = f)) and
//     not exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(1))) 
//     or
//     // For reject calls and no resolve calls:
//     (exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and 
//                                     cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(1) and
//                                     not exists(Function f | f.getParent*() = ne.getAstNode() and
//                                                             f.getName() = "setTimeout" and
//                                                             //  not ne.getAnArgument().getAstNode() = f and
//                                                             cn.getAstNode().getParent*() = f)) and
//     not exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(0))))
// }