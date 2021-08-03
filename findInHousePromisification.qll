import javascript

// These names are all taken from the fs Promises API. These functions all have
// promise-based APIs supported already by fs.
predicate nameIsFromFS (string n) {
    n in [
        "appendFile",       // Start: from FileHandle class...
        "chmod",
        "chown",
        "close",
        "datasync",
        "fd",
        "read",
        "readFile",
        "readv", 
        "stat", 
        "sync",
        "truncate",
        "utimes",
        "write",
        "writeFile",
        "writev",           // End: from FileHandle class...
        "access",
        "appendFile",
        "chmod",
        "chown",
        "copyFile",
        "lchmod",
        "lchown",
        "lutimes",
        "link",
        "lstat",
        "mkdir",
        "mkdtemp",
        "open",
        "opendir",
        "readdir",
        "readFile",
        "readlink",
        "realpath",
        "rename",
        "rmdir",
        "rm",
        "stat",
        "symlink",
        "truncate",
        "unlink",
        "utimes",
        "watch",
        "writeFile"
    ]
}

// Matches instances where a function being defined has the same name as one of the fs
// functions which already have supported promise-based APIs, and that function also
// returns a promise.
//
// TODO: Should we expand on this, to make it use data flow? To catch more cases of where
// promises can flow to the return.
predicate isFSRedefinition (Function f) {
    nameIsFromFS(f.getName()) and
    ((NewExpr) f.getAReturnedExpr()).getCalleeName() = "Promise"
}

predicate isInHousePromisification (Function f) {
    isFSRedefinition(f)
}