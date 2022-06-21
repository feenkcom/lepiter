Class {
	#name : #LeInsertSnippetAfterChildUidPosition,
	#superclass : #LeInsertSnippetPosition,
	#instVars : [
		'snippetUid'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #action }
LeInsertSnippetAfterChildUidPosition >> insertChildSnippet: aChildSnippet intoParent: aParentContent [
	self assert: [ self snippetUid notNil ].
	
	aParentContent children 
		detect: [ :aSnippet | aSnippet uid = self snippetUid ] 
		ifFound: [ :aSnippet | 
			aParentContent addSnippet: aChildSnippet after: aSnippet ]  
		ifNone: [ Error signal: 'After snippet not found.' ]
]

{ #category : #accessing }
LeInsertSnippetAfterChildUidPosition >> snippetUid [

	^ snippetUid
]

{ #category : #accessing }
LeInsertSnippetAfterChildUidPosition >> snippetUid: anObject [

	snippetUid := anObject
]
