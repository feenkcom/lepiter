Class {
	#name : #LePythonApplicationDatabaseStrategy,
	#superclass : #LePythonApplicationStrategy,
	#category : 'Lepiter-Python-Settings'
}

{ #category : #accessing }
LePythonApplicationDatabaseStrategy class >> pbApplicationFor: aLePythonSnippetElement [
	| newPbApplication |

	aLePythonSnippetElement database isDatabase ifFalse: [ ^ nil ].
	^ aLePythonSnippetElement database 
		optionAt: #pythonApplication 
		ifPresent: [ :pbApplication | pbApplication ]
		ifAbsent: 
			[ newPbApplication := self newPbApplicationFor: aLePythonSnippetElement database.
			aLePythonSnippetElement database optionAt: #pythonApplication put: newPbApplication.
			newPbApplication. ]
]

{ #category : #naming }
LePythonApplicationDatabaseStrategy class >> strategyName [

	^ #database
]
