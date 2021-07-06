import javascript

class PTADataFlowConfiguration extends DataFlow::Configuration {
    PTADataFlowConfiguration() { this = "PTADataFlowConfiguration" }

    override predicate isSource(DataFlow::Node source) { 
        isCallToAsyncFunction(source) or
        isCallToPromiseConstructor(source)
    }

    override predicate isSink(DataFlow::Node sink) {
        sink.asExpr().getParentExpr() instanceof AwaitExpr
    }

    predicate isCallToAsyncFunction(DataFlow::Node source) {
        source instanceof DataFlow::InvokeNode and
        ((DataFlow::InvokeNode) source).getACallee().isAsync()
    }

    predicate isCallToPromiseConstructor(DataFlow::Node source) {
        source instanceof DataFlow::NewNode and
        ((DataFlow::NewNode) source).getCalleeName() = "Promise"
    }
}

class PromiseAwaitExpr extends AwaitExpr {
    PromiseAwaitExpr() {
        exists(PTADataFlowConfiguration dataFlow, DataFlow::Node source, DataFlow::Node sink |
            dataFlow.hasFlow(source, sink)
            and this = sink.getEnclosingExpr().getParentExpr())
    }
}

predicate isAwaitedValue (AwaitExpr ae) {
    not ae instanceof PromiseAwaitExpr
}
