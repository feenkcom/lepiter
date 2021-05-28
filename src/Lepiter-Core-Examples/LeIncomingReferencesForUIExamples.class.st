Class {
	#name : #LeIncomingReferencesForUIExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #'examples - model' }
LeIncomingReferencesForUIExamples >> database [
	<gtExample>
	| database folderReference localStore  |
	folderReference := FileSystem memory / 'storage-main'.
	folderReference ensureCreateDirectory.
	
	localStore := LeLocalStoreLoad current.
	localStore localRoot: folderReference.
	database := localStore loadAndMonitorFrom: folderReference.
	self assert: database explicitLinks size equals: 0.
	^ database 
]

{ #category : #'examples - model' }
LeIncomingReferencesForUIExamples >> databaseWithLinkedReferencesAmongPages [
	<gtExample>
	| aDatabase aPage |
	aDatabase := self database.

	"one"
	aPage := aDatabase pageBuilder title: 'one'; add.
	aPage snippetBuilder string: 'one > one'; add.
	aPage snippetBuilder string: 'one > two [[three]]'; add.
	aPage snippetBuilder string: 'one > three [[four]]'; add.

	"two"
	aPage := aDatabase pageBuilder title: 'two'; add.
	aPage snippetBuilder string: 'two > one'; add.
	aPage snippetBuilder string: 'two > two [[three]]'; add.

	"three"
	aPage := aDatabase pageBuilder title: 'three'; add.
	aPage snippetBuilder string: 'three > one'; add.
	aPage snippetBuilder string: 'three > two'; add.

	"four"
	aPage :=  aDatabase pageBuilder title: 'four'; add.
	aPage snippetBuilder string: 'four > one [[four]]'; add.
	aPage snippetBuilder string: 'four > two'; add.

	^ aDatabase
]

{ #category : #'examples - model' }
LeIncomingReferencesForUIExamples >> linkedReferences_PageThree [
	<gtExample>
	| aPage aReference |

	aPage := self pageThreeOfDatabaseWithLinkedReferencesAmongPages.
	aReference := (LeLinksSelector default rootsFor: aPage) first.

	^ aReference
]

{ #category : #'examples - model' }
LeIncomingReferencesForUIExamples >> pageThreeOfDatabaseWithLinkedReferencesAmongPages [
	<gtExample>
	| aDatabase aPage |
	aDatabase := self databaseWithLinkedReferencesAmongPages.
	aPage := aDatabase pageNamed: 'three'.
	^ aPage
]
