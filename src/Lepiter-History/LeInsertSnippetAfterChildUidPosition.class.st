Class {
	#name : #LeInsertSnippetAfterChildUidPosition,
	#superclass : #LeInsertSnippetPosition,
	#instVars : [
		'snippetUid'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeInsertSnippetAfterChildUidPosition >> descriptionOn: aStream [
	aStream 
		<< 'After child uid: ';
		print: self snippetUid
]

{ #category : #action }
LeInsertSnippetAfterChildUidPosition >> insertChildSnippet: aChildSnippet intoParent: aParentContent [
	self assert: [ self snippetUid notNil ].
	
	aParentContent children 
		detect: [ :aSnippet | aSnippet uid = self snippetUid ] 
		ifFound: [ :aSnippet | 
			aParentContent addSnippet: aChildSnippet after: aSnippet ]  
		ifNone: [ Error signal: 'After snippet not found.' ]
]

{ #category : #printing }
LeInsertSnippetAfterChildUidPosition >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [ 
		aStream  
			<< 'childUid: ';
			print: self snippetUid ]
]

{ #category : #accessing }
LeInsertSnippetAfterChildUidPosition >> snippetUid [

	^ snippetUid
]

{ #category : #accessing }
LeInsertSnippetAfterChildUidPosition >> snippetUid: anObject [

	snippetUid := anObject
]
