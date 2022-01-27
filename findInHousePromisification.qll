import javascript

/*

  matches something like:

  new Promise((res, rej) => {
    someFun(1, 2, 3, (err, val) => {
      if (err)
        rej(err)
      else
        res(val)
    });
  });

*/

class PromiseConstructorNodeWithCall extends DataFlow::NewNode {
  DataFlow::FunctionNode fctArg;
  PromiseConstructorNodeWithCall() {
    this.getCalleeName() = "Promise" and
    this.getArgument(0) = fctArg
  }
 
  DataFlow::FunctionNode getFctArg() {
    result = fctArg
  }
}

predicate inHousePromisificationNewPromise(PromiseConstructorNodeWithCall np) {
    exists(IfStmt ifStmt, CallExpr ce, DataFlow::FunctionNode f |
        ifStmt.getParent*() = ce and
        ce.getParent*() = np.getAstNode() and
        f.getAstNode() = ce.getAnArgument() and
        exists(DataFlow::CallNode cn_reaction |
            (cn_reaction.getCalleeNode().getALocalSource() = np.getFctArg().getParameter(0) or
            cn_reaction.getCalleeNode().getALocalSource() = np.getFctArg().getParameter(1)) and
            cn_reaction.getAnArgument().getALocalSource() = f.getAParameter()))
}

/*
predicate inHousePromisificationNewPromise(DataFlow::NewNode np) {
    np.getCalleeName() = "Promise" and
    exists(IfStmt ifStmt, CallExpr ce, DataFlow::FunctionNode f | 
        ifStmt.getParent*() = ce and
        ce.getParent*() = np.getAstNode() and
        f.getAstNode() = ce.getAnArgument() and
        exists(DataFlow::CallNode cn_res, DataFlow::CallNode cn_rej | 
            (cn_res.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) np.getArgument(0)).getParameter(0) or
            cn_rej.getCalleeNode().getALocalSource() = ((DataFlow::FunctionNode) np.getArgument(0)).getParameter(1)) and
            (cn_res.getAnArgument().getALocalSource() = f.getAParameter() or
            cn_rej.getAnArgument().getALocalSource() = f.getAParameter())))
}
*/