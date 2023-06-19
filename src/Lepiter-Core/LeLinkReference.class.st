Class {
	#name : #LeLinkReference,
	#superclass : #LeModel,
	#instVars : [
		'explicitLink'
	],
	#category : #'Lepiter-Core-Links'
}

{ #category : #accessing }
LeLinkReference >> description [
	^ self class name
]

{ #category : #accessing }
LeLinkReference >> explicitLink [
	^ explicitLink
]

{ #category : #accessing }
LeLinkReference >> explicitLink: anExplicitLink [
	self assert: [ anExplicitLink notNil ].
	self assert: [ explicitLink isNil ].
	
	explicitLink := anExplicitLink
]

{ #category : #'gt - extensions' }
LeLinkReference >> gtViewDefaultMatchingOriginLinksFor: aView [
	<gtView>
	self explicitLink ifNotNil: [ ^ aView empty ].
	^ aView forward
		title: 'Matching origin links';
		priority: 10;
		object: [ 
			| defaultDatabase |
			defaultDatabase := LeDatabasesRegistry uniqueInstance defaultPrimaryDatabase.
			self linksWithMatchingOriginReferenceInDatabase: defaultDatabase ];
		view: #gtViewExplicitLinksFor:
]

{ #category : #'gt - extensions' }
LeLinkReference >> gtViewDefaultMatchingTargetLinksFor: aView [
	<gtView>
	self explicitLink ifNotNil: [ ^ aView empty ].
	^ aView forward
		title: 'Matching target links';
		priority: 5;
		object: [ 
			| defaultDatabase |
			defaultDatabase := LeDatabasesRegistry uniqueInstance defaultPrimaryDatabase.
			self linksWithMatchingTargetReferenceInDatabase: defaultDatabase ];
		view: #gtViewExplicitLinksFor:
]

{ #category : #'gt - extensions' }
LeLinkReference >> gtViewMatchingOriginLinksFor: aView [
	<gtView>
	self explicitLink ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Matching origin links';
		priority: 10;
		object: [ self linksWithMatchingOriginReference ];
		view: #gtViewExplicitLinksFor:
]

{ #category : #'gt - extensions' }
LeLinkReference >> gtViewMatchingTargetLinksFor: aView [
	<gtView>
	self explicitLink ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Matching target links';
		priority: 5;
		object: [ self linksWithMatchingTargetReference ];
		view: #gtViewExplicitLinksFor:
]

{ #category : #testing }
LeLinkReference >> isExternalReference [
	^ false
]

{ #category : #testing }
LeLinkReference >> isLeContentReference [
	^ false
]

{ #category : #testing }
LeLinkReference >> isPageReference [
	^ false
]

{ #category : #testing }
LeLinkReference >> isSnippetReference [
	^ false
]

{ #category : #query }
LeLinkReference >> linksWithMatchingOriginReference [
	^ self linksWithMatchingOriginReferenceInDatabase: self explicitLink database
]

{ #category : #query }
LeLinkReference >> linksWithMatchingOriginReferenceInDatabase: aDatabase [
	^ aDatabase linksWithOriginReferenceMatching: self
]

{ #category : #query }
LeLinkReference >> linksWithMatchingTargetReference [
	^ self linksWithMatchingTargetReferenceInDatabase: self explicitLink database
]

{ #category : #query }
LeLinkReference >> linksWithMatchingTargetReferenceInDatabase: aDatabase [
	^ aDatabase linksWithTargetReferenceMatching: self
]

{ #category : #testing }
LeLinkReference >> matches: anotherObject [
	self == anotherObject ifTrue: [ ^ true ].
	(anotherObject class = self class)
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #copying }
LeLinkReference >> postCopy [
	super postCopy.
	explicitLink := nil
]

{ #category : #actions }
LeLinkReference >> resolveAndLinkReference [
]

{ #category : #actions }
LeLinkReference >> resolveReference [
]

{ #category : #accessing }
LeLinkReference >> status [
	^ LeLinkReferenceStatus indecisive
]

{ #category : #actions }
LeLinkReference >> unlink [
]
