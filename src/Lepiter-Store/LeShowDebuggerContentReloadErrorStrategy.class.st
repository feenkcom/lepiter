"
Executes the given computation normally without any kind of wrapping. This raises errors normally.
"
Class {
	#name : #LeShowDebuggerContentReloadErrorStrategy,
	#superclass : #LeDatabaseContentReloadErrorStrategy,
	#category : #'Lepiter-Store-Reload'
}

{ #category : #action }
LeShowDebuggerContentReloadErrorStrategy >> executeManaged: aBlock [
	"Simply execute the given block to raise all errors normally."
	^ aBlock value
]
