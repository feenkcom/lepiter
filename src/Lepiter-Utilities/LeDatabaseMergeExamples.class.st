Class {
	#name : #LeDatabaseMergeExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Utilities-Examples'
}

{ #category : #examples }
LeDatabaseMergeExamples >> merge [
	"Merge two databases and answer the merge db"

	<gtExample>
	<return: #LeDatabase>
	| source target commonPage pageSource1 sourceTarget1 target1 emails |
	source := self sourceDatabase.
	target := self targetDatabase.
	LeDatabaseMerge merge: source into: target.
	self assert: target pageCount equals: 4.
	commonPage := target pageNamed: 'Common 1'.
	self assert: commonPage childrenCount equals: 3.

	sourceTarget1 := target pageNamed: 'Source Target 1'.
	pageSource1 := target pageNamed: 'Source 1'.	"Check that the link to 'Common 1' is correctly merged"
	self
		assert: (pageSource1 children at: 2) outgoingExplicitLinks first target
		identicalTo: commonPage.	"Check that the links to 'Source Target 1' are correctly merged"
	self
		assert: (pageSource1 children at: 3) outgoingExplicitLinks first target
		identicalTo: sourceTarget1.
	self
		assert: ((pageSource1 children at: 1) children at: 1) outgoingExplicitLinks first target
		equals: sourceTarget1.

	self assert: sourceTarget1 incomingLinks size equals: 2.	"Check that every block has email addresses"
	emails := {self sourceEmail.
			self targetEmail}.
	target1 := target pageNamed: 'Target 1'.
	target
		allChildrenBreadthFirstDo: [ :child | 
			self assert: (emails includes: child editEmail email).
			self assert: (emails includes: child createEmail email) ].	"Check two blocks have the correct email address"
	self
		assert: (pageSource1 children at: 1) editEmail email
		equals: self sourceEmail.
	self assert: (target1 children at: 1) editEmail email equals: self targetEmail.

	^ target
]

{ #category : #accessing }
LeDatabaseMergeExamples >> sourceDatabase [ 
	| database page snippet |

	database := LeDatabase new.
	database userEmail: self sourceEmail.
	
	"Add pages referenced in links"
	database pageBuilder
		title: 'Source Target 1';
		add.
	database pageBuilder
		title: 'Common 1';
		add.
		
	page := database pageBuilder
		title: 'Source 1';
		add.
	snippet := page snippetBuilder
		string: 'Source 1 Block 1';
		add.
	snippet snippetBuilder
		string: 'Source 1 Block 1 Sub 1 link to [[Source Target 1]]';
		add.
	snippet snippetBuilder
		string: 'Source 1 Block 1 Sub 2';
		add.
	page snippetBuilder
		string: 'Source link to [[Common 1]].';
		add.
	page snippetBuilder
		string: 'Source link to [[Source Target 1]].';
		add.

	page := database pageNamed: 'Common 1'.
	page snippetBuilder
		string: 'Common 1 Source Block 1';
		add.
	snippet := page snippetBuilder
		string: 'Common 1 Duplicate Source Block 1';
		add.
	"Force the uid to a known value for testing merge rules"
	snippet uidString: 'UaP+TQGADQCSxU4BCO2heg=='.
	

	^ database
]

{ #category : #accessing }
LeDatabaseMergeExamples >> sourceEmail [

	^ 'source@email.com'
]

{ #category : #accessing }
LeDatabaseMergeExamples >> targetDatabase [ 
	| database page snippet |

	database := LeDatabase new.
	database userEmail: self targetEmail.
	page := database pageBuilder
		title: 'Target 1';
		add.
	snippet := page snippetBuilder
		string: 'Target 1 Block 1';
		add.
	snippet snippetBuilder
		string: 'Target 1 Block 1 Sub 1';
		add.

	page := database pageBuilder
		title: 'Common 1';
		add.
	page snippetBuilder
		string: 'Common 1 Target Block 1';
		add.
	snippet := page snippetBuilder
		string: 'Common 1 Duplicate Target Block 1';
		add.
	"Force the uid to a known value for testing merge rules"
	snippet uidString: 'UaP+TQGADQCSxU4BCO2heg=='.


	^ database
]

{ #category : #accessing }
LeDatabaseMergeExamples >> targetEmail [

	^ 'target@email.com'
]
