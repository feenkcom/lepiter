"
GtAbstractLepiterDb provides a number of utilities that assist in the management of class based lepiter databases, e.g. viewing pages directly from the store, finding the current database using the class as its store, etc.
"
Class {
	#name : #GtAbstractLepiterDb,
	#superclass : #Object,
	#category : #'Lepiter-Store-Class-Storage'
}

{ #category : #accessing }
GtAbstractLepiterDb class >> defaultDatabase [
	"Answer the LeDatabase that uses the receiver as its store"
	| logicalDatabase |

	logicalDatabase := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase.
	^ logicalDatabase databases detect: [ :db |
		db monitor class == LeDatabaseClassStoreMonitor
			and: [ db monitor dbClass == self ] ]
]
