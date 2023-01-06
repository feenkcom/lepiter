Class {
	#name : #LeInsertSnippetBeforeChildUidPosition,
	#superclass : #LeInsertSnippetPosition,
	#instVars : [
		'snippetUid'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeInsertSnippetBeforeChildUidPosition >> descriptionOn: aStream [
	aStream 
		<< 'Before child uid: ';
		print: self snippetUid
]

{ #category : #action }
LeInsertSnippetBeforeChildUidPosition >> insertChildSnippet: aChildSnippet intoParent: aParentContent [
	self assert: [ self snippetUid notNil ].
	
	aParentContent children 
		detect: [ :aSnippet | aSnippet uid = self snippetUid ] 
		ifFound: [ :aSnippet | 
			aParentContent addSnippet: aChildSnippet before: aSnippet ]  
		ifNone: [ Error signal: 'After snippet not found.' ]
]

{ #category : #printing }
LeInsertSnippetBeforeChildUidPosition >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [ 
		aStream  
			<< 'childUid: ';
			print: self snippetUid ]
]

{ #category : #accessing }
LeInsertSnippetBeforeChildUidPosition >> snippetUid [
	^ snippetUid
]

{ #category : #accessing }
LeInsertSnippetBeforeChildUidPosition >> snippetUid: anUid [
	snippetUid := anUid
]
