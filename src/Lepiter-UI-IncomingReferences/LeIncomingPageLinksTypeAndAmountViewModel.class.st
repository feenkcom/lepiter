Class {
	#name : #LeIncomingPageLinksTypeAndAmountViewModel,
	#superclass : #LeDynamicSnippetViewModel,
	#traits : 'TLeWithIncomingPageLinksGroupModel',
	#classTraits : 'TLeWithIncomingPageLinksGroupModel classTrait',
	#instVars : [
		'uid'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #accessing }
LeIncomingPageLinksTypeAndAmountViewModel >> displayLabel [
	<return: #String>
	| aGroupType aLinksCount |
	
	"we could have some sort of a dispatch through the links group model,
	however, since there are just two possible logical types (explicit/implicit) we do it here directly"
	aGroupType := self incomingPageLinksGroupModel isExplicit
		ifTrue: [ 'explicit' ]
		ifFalse: [ self incomingPageLinksGroupModel isImplicit
			ifTrue: [ 'implicit' ]
			ifFalse: [ 'other' ] ].

	aLinksCount := self incomingPageLinksGroupModel size.

	^ String streamContents: [ :stream |
		stream 
			print: aLinksCount;
			space;
			nextPutAll: aGroupType;
			space;
			nextPutAll: 'reference'.
		aLinksCount > 1
			ifTrue: [ stream nextPutAll: 's' ] ]
]

{ #category : #'api - incoming page links group model' }
LeIncomingPageLinksTypeAndAmountViewModel >> onIncomingPageLinksGroupModelChanged [
	"Is sent when a new incomingPageLinksGroup model is assigned to the view model"
	
	
]

{ #category : #accessing }
LeIncomingPageLinksTypeAndAmountViewModel >> snippetElementClass [
	^ LeIncomingPageLinksTypeAndAmountElement
]

{ #category : #accessing }
LeIncomingPageLinksTypeAndAmountViewModel >> uid [
	"We generate a new uid to uniquely identity this snupper view model"
	<return: #LeUID>

	^ uid ifNil: [ uid := self referencedPage database newUID ]
]
