"
LeSnippetUIDRepair walks over database files and reassigns snippet UIDs to ensure that there are no duplicates.

NOTE: This utility assumes that it is OK to reassign the Snippet UIDs without any further updating.

Limitations:

- This has only be tested for JSON V3 databases.
- No attempt is made to update links to snippets (which haven't been used at the time of writing).
- The DB schema is assumed to be up-to-date.
- There aren't any automated tests for this class.
- It isn't maintained.

The intention is to resolve what is presumed to be a historical issue where duplicate snippets UIDs were created.

Basic instructions:

1. Take a backup copy of the DB
2. Ensure that no DBs are open, or at least that the monitors are stopped:

``` 
	LeLocalStoreMonitor allInstancesDo: [ :monitor | monitor stopMonitoring ]
```

3. Run the repair on the target DB:

``` 
LeSnippetUIDRepair new
   dbFileReference: '/path/to/the/db';
   run.
```

4. Restart the image since any in-memory copy of the DB will now be out of sync.

"
Class {
	#name : #LeSnippetUIDRepair,
	#superclass : #Object,
	#instVars : [
		'dbFileReference',
		'store',
		'snippetUIDs',
		'pages'
	],
	#category : 'Lepiter-Utilities'
}

{ #category : #private }
LeSnippetUIDRepair >> assignNewUIDTo: snippet [
	"Assign a new UID to the supplied snippet.
	Use the DB to create the snippet, but check that it isn't a duplicate locally.
	This ensures that the UID format is defined by the DB, but avoids the need to actually load the DB (which we don't want to do to avoid creating new pages on the fly)"
	| uid |

	[ uid := self database newUID.
	snippetUIDs includes: uid uid ] whileTrue.
	snippet uid: uid.
]

{ #category : #private }
LeSnippetUIDRepair >> checkPages [
	"For each page: 
	- iterate over each snippet
	- if the snippet UID already exists, assign a new UID
	- add the snippet UID to the list of known IDs
	- if the snippet was changed, save the snippet"
	| pageChanged |

	pages do: [ :page |
		pageChanged := false.
		page allChildrenBreadthFirstDo: [ :snippet |
			(snippetUIDs includes: snippet uidString) ifTrue: 
				[ pageChanged := true.
				self assignNewUIDTo: snippet ].
			snippetUIDs add: snippet uidString ].
		pageChanged ifTrue: 
			[ store savePageNow: page ] ]
]

{ #category : #accessing }
LeSnippetUIDRepair >> database [
	^ store database
]

{ #category : #accessing }
LeSnippetUIDRepair >> dbFileReference [
	^ dbFileReference
]

{ #category : #accessing }
LeSnippetUIDRepair >> dbFileReference: aFileReference [

	dbFileReference := aFileReference asFileReference.
]

{ #category : #initialization }
LeSnippetUIDRepair >> initialize [

	super initialize.
	snippetUIDs := Set new.
]

{ #category : #running }
LeSnippetUIDRepair >> run [

	self assert: dbFileReference isDirectory.
	store := LeLocalStoreLoad current 
		localRoot: dbFileReference;
		database: LeDatabase new.
	pages := store loadPagesIn: dbFileReference.
	self checkPages.
]
