Class {
	#name : #LeGitHubInputFieldId,
	#superclass : #BlElementId,
	#instVars : [
		'name'
	],
	#category : #'Lepiter-GitHub-UI IDs'
}

{ #category : #comparing }
LeGitHubInputFieldId >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].

	self class = anObject class ifFalse: [ ^ false ].

	^ self name = anObject name
]

{ #category : #converting }
LeGitHubInputFieldId >> asSymbol [
	^ self name
]

{ #category : #'gt-extensions' }
LeGitHubInputFieldId >> gtReferencesFor: aView [
	<gtView>
	^ aView explicit
		title: 'References';
		stencil: [ self class gtReferences ]
]

{ #category : #comparing }
LeGitHubInputFieldId >> hash [
	^ self class hash bitXor: self name hash
]

{ #category : #'api - accessing' }
LeGitHubInputFieldId >> name [
	^ name
]

{ #category : #'api - accessing' }
LeGitHubInputFieldId >> name: aSymbol [

	name
		ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].

	self
		assert: [ aSymbol notNil ]
		description: [ 'Identifier must be non-nil' ].

	name := aSymbol asSymbol
]
