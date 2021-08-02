import javascript

predicate nameIsFromFS (string n) {
    n in [
        "readFile",
        "writeFile"
    ]
}

// Do we want to do this with dataflow? 
// To see if a promise flows to the return value?
predicate isFSRedefinition (Function f) {
    nameIsFromFS(f.getName()) and
    ((NewExpr) f.getAReturnedExpr()).getCalleeName() = "Promise"
}

predicate isInHousePromisification (Function f) {
    isFSRedefinition(f)
}