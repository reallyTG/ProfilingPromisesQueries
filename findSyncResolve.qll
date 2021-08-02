import javascript

predicate isPromiseConstructorWithSyncResolve(DataFlow::NewNode ne) {
    ne.getCalleeName() = "Promise" and
    // For resolve calls and no reject calls:
    ((exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(0)) and
    not exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(1))) or
    // For reject calls and no resolve calls:
    (exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(1)) and
    not exists(DataFlow::CallNode cn | cn.getAstNode().getParent*() = ne.getAstNode() and cn.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) ne.getArgument(0)).getParameter(0))))
}