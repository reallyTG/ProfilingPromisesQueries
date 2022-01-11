import javascript
bindingset[filepath]
predicate isTestDir(string filepath) {
 	filepath.matches("%testing_repos%tests%") or
  	filepath.matches("%testing_repos%mocks%") or
  	filepath.matches("%testing_repos%init%") or
  	filepath.matches("%testing_repos%config%") or
  	filepath.matches("%testing_repos%docs%") or
  	filepath.matches("%testing_repos%gulpfile%") or
  	filepath.matches("%testing_repos%grunt%") or
  	filepath.matches("%testing_repos%gulp%") or
  	filepath.matches("%testing_repos%test%") or
  	filepath.matches("%testing_repos%mock%") or
  	filepath.matches("%testing_repos%dist%") or
  	filepath.matches("%testing_repos%.tmp%") or
  	filepath.matches("%testing_repos%bin%") 
}
bindingset[filename]
predicate isTestFile(string filename) {
 	filename.matches("%testing_repos%spec.%") or
  	filename.matches("%testing_repos%mocha.%") or
  	filename.matches("%testing_repos%test.%") or
  	filename.matches("%testing_repos%mock.%") or
  	filename.matches("%testing_repos%conf.%") or
  	filename.matches("%testing_repos%gruntfile.%") or
  	filename.matches("%testing_repos%gulpfile.%") or
  	filename.matches("%testing_repos%webpack.%") 
}
class SourceFile extends File {
	SourceFile() {
      not ( 
        isTestDir(this.getAbsolutePath().toLowerCase()) or 
        isTestFile(getAbsolutePath().toLowerCase())
      )
  	}
}
bindingset[functionName]
predicate isSynchronousFctName(string functionName) {
    functionName in [
        "readFileSync", 
        "writeFileSync", 
        "readdirSync", 
        "accessSync", 
        "appendFileSync", 
        "chmodSync",
        "fchmodSync", 
        "lchmodSync",
        "chownSync",
        "fchownSync",
        "lchownSync", 
        "mkdirSync", 
        "mkdtempSync",
        "statSync", 
        "lstatSync",
        "fstatSync",
        "linkSync",
        "symlinkSync",
        "readlinkSync",
        "realpathSync",
        "unlinkSync",
        "rmdirSync",
        "renameSync", 
        "openSync",
        "closeSync",
        "existsSync", 
        "copyFileSync",
        "truncateSync",
        "ftruncateSync",
        "utimesSync",
        "futimesSync",
        "fsyncSync",
        "writeSync",
        "readSync",
        "fdatasyncSync",
        "gzipSync", 
        "gunzipSync", 
        "brotliCompressSync",
        "brotliDecompressSync", 
        "deflateSync",
        "inflateSync", 
        "deflateRawSync",
        "inflateRawSync", 
        "unzipSync",
        "execSync",
        "spawnSync",
        "execFileSync",
        "pbkdf2Sync", 
        "generateKeyPairSync",
        "randomFillSync",
        "scryptSync",
        "existsSync", // from path
        "readFileSync", // from jsonfile
        "writeFileSync" // from jsonfile
    ]
}
class SyncCallExpr extends CallExpr {
	SyncCallExpr() {
  		isSynchronousFctName(this.getCalleeName())
  	}
}

int getNumLOC() {
	result = sum( any(File f).getNumberOfLinesOfCode())
}
int getNumFunctionsInFile( File f) {
	result = count( Function fct | fct.getFile() = f)
}
int getNumFilesInFolder(Folder d) {
	result = count(File f | f.getParentContainer() = d and f.getExtension() = "js" )
}
int getNumFiles() {
	result = sum(getNumFilesInFolder( any(Folder f) ))
}
int getNumFunctions() {
	result = sum( getNumFunctionsInFile( any(File f)))
}
int getNumSyncFunctionsInFile( SyncCallExpr c) {
	result = count(  c )
}
int getNumSyncFunctions() {
	result = sum( getNumSyncFunctionsInFile( any(SyncCallExpr c)))
}

from Expr e
where e.getFile() instanceof SourceFile 
select getNumLOC() as LOC, getNumFiles() as Files, getNumFunctions() as Functions
