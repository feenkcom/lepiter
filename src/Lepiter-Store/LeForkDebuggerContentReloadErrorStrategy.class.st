"
This strategy gives callers a chance to handle errors first by catching {{gtClass:UnhandledError}}.
If there is no handler, it forks the exception so the load can continue.
"
Class {
	#name : #LeForkDebuggerContentReloadErrorStrategy,
	#superclass : #LeDatabaseContentReloadErrorStrategy,
	#category : #'Lepiter-Store-Reload'
}

{ #category : #action }
LeForkDebuggerContentReloadErrorStrategy >> executeManaged: aBlock [
	"Use Block>>#on:fork: to give callers a chance to handle the error before opening a debugger in a new process"
	^ aBlock
		on: UnhandledError 
		fork: [ :ex | ex pass ]
]
