"
LeDbManualExternalCommitter provides a way to simply initiate a git commit and sync sequence of operations from Lepiter.

If initialised, a ""Commit Lepiter DB Directory"" button will appear on the page inspector (which needs to be switched to from the page view).

The following methods are used for configuring the committer: 

- addDirectory: add a directory to be committed. This is the git root directory, not the DB directory.
- syncCommand: if you want to push the repository, set the command here.  Note that this is not a shell command.
- preCommitValuable: supply a valuable, e.g. a one argument block closure, that will be evaluated prior to committing (but after printing the status).
- postCommitValuable: supply a valuable, e.g. a one argument block closure, that will be evaluated after committing.

This can be added to, e.g., a preload script for the database.

Example setup: 

```
LeDbManualExternalCommitter uniqueInstance
	reset;
	addDirectory: '/path/to/git/repository';
	syncCommand: '/path/to/git-sync'.
```

"
Class {
	#name : #LeDbManualExternalCommitter,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'dbDirs',
		'syncCommand',
		'stdout',
		'stderr',
		'postCommitValuable',
		'preCommitValuable'
	],
	#category : #'Lepiter-Utilities-CommitButton'
}

{ #category : #private }
LeDbManualExternalCommitter >> addAllFiles: dbDir [
	| proc |

	self appendToOuputStreams: 'Add All Files:'.
	proc := (GtSubprocessWithInMemoryOutput
		command: 'git'
		arguments: { 'add'. '*' })
		workingDirectory: dbDir.
	proc runAndWait.
	proc isSuccess ifFalse: 
		[ self error: 'Failed to add contents to the index' ].
	self appendStdio: proc.
]

{ #category : #configuration }
LeDbManualExternalCommitter >> addDirectory: aFileReference [
	"Add the supplied directory to the list to be committed.
	This must be the root directory of the git repository"
	| fileReference |

	fileReference := aFileReference asFileReference.
	self assert: fileReference isDirectory.
	self assert: (fileReference / '.git') isDirectory.

	dbDirs add: fileReference.
]

{ #category : #private }
LeDbManualExternalCommitter >> appendStdio: proc [

	stdout := String streamContents: [ :stream |
		stream << stdout.
		proc stdout ifNotEmpty:
			[ stdout ifNotEmpty: [ stream cr; cr].
			stream << proc stdout ] ].
	stderr := String streamContents: [ :stream |
		stream << stderr.
		proc stderr ifNotEmpty: 
			[ stderr ifNotEmpty: [ stream cr; cr ].
			stream << proc stderr ] ].
]

{ #category : #private }
LeDbManualExternalCommitter >> appendToOuputStreams: aString [ 

	stdout := String streamContents: [ :stream |
		stream
			<< stdout; cr;
			<< aString; cr ].
	stderr := String streamContents: [ :stream |
		stream
			<< stderr; cr;
			<< aString; cr ].

]

{ #category : #private }
LeDbManualExternalCommitter >> commit: dbDir [
	| proc |

	self appendToOuputStreams: 'Commit: '.
	proc := (GtSubprocessWithInMemoryOutput
		command: 'git'
		arguments: { 'commit'. '-m'. DateAndTime now printToMinute. })
		workingDirectory: dbDir.
	proc runAndWait.
	"Nothing to commit is not considered an error"
	proc isSuccess ifFalse: 
		[ (proc stdout includesSubstring: 'nothing to commit, working tree clean') ifFalse:
			[ self error: 'Failed to commit' ] ].
	self appendStdio: proc.
]

{ #category : #running }
LeDbManualExternalCommitter >> commitAll [ 
	"Commit and sync the current state"

	stdout := ''.
	stderr := ''.
	dbDirs do: [ :dbDir |
		self appendToOuputStreams: 'Committing: ', dbDir fullName, String cr.
		self status: dbDir.
		preCommitValuable value: dbDir.
		self addAllFiles: dbDir.
		self commit: dbDir.
		self sync: dbDir.
		postCommitValuable value: dbDir.
		self appendToOuputStreams: 'Committed: ', dbDir fullName ].
]

{ #category : #ui }
LeDbManualExternalCommitter >> gtStderrFor: aView [
	<gtView>

	(stderr isNil or: [ stderr isEmpty ]) ifTrue: [ ^ aView empty ].
	^ aView textEditor 
		title: 'stderr';
		priority: 10;
		text: [ stderr asRopedText ]
]

{ #category : #ui }
LeDbManualExternalCommitter >> gtStdoutFor: aView [
	<gtView>

	(stdout isNil or: [ stdout isEmpty ]) ifTrue: [ ^ aView empty ].
	^ aView textEditor 
		title: 'stdout';
		priority: 10;
		text: [ stdout asRopedText ]
]

{ #category : #testing }
LeDbManualExternalCommitter >> hasDbDirs [
	"Answer a boolean indicating whether the receiver has directories configured"

	^ dbDirs isNotEmpty
]

{ #category : #initialization }
LeDbManualExternalCommitter >> initialize [ 

	super initialize.
	self reset.
]

{ #category : #accessing }
LeDbManualExternalCommitter >> postCommitValuable [
	^ postCommitValuable
]

{ #category : #accessing }
LeDbManualExternalCommitter >> postCommitValuable: anObject [
	postCommitValuable := anObject
]

{ #category : #accessing }
LeDbManualExternalCommitter >> preCommitValuable [
	^ preCommitValuable
]

{ #category : #accessing }
LeDbManualExternalCommitter >> preCommitValuable: anObject [
	preCommitValuable := anObject
]

{ #category : #initialization }
LeDbManualExternalCommitter >> reset [

	stdout := ''.
	stderr := ''.
	dbDirs := Set new.
	preCommitValuable := [ :dbDir | ].
	postCommitValuable := [ :dbDir | ].
]

{ #category : #private }
LeDbManualExternalCommitter >> status: dbDir [
	| proc |

	self appendToOuputStreams: 'Status:'.
	proc := (GtSubprocessWithInMemoryOutput
		command: 'git'
		arguments: { 'status'. })
		workingDirectory: dbDir.
	proc runAndWait.
	"Nothing to commit is not considered an error"
	proc isSuccess ifFalse: 
		[ self error: 'Failed to get status' ].
	self appendStdio: proc.
]

{ #category : #private }
LeDbManualExternalCommitter >> sync: dbDir [
	| proc |

	self appendToOuputStreams: 'Sync:'.
	syncCommand ifNil: [ ^ self ].
	proc := (GtSubprocessWithInMemoryOutput
		command: syncCommand
		arguments: #())
		workingDirectory: dbDir.
	proc runAndWait.
	proc isSuccess ifFalse: 
		[ self error: 'Failed to sync' ].
	self appendStdio: proc.
]

{ #category : #configuration }
LeDbManualExternalCommitter >> syncCommand: aStringOrNil [

	self assert: (aStringOrNil isNil or: [ aStringOrNil isString ]).
	syncCommand := aStringOrNil.
]
