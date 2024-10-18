Class {
	#name : #LeReplaceSubtextCompletionAction,
	#superclass : #GtReplaceSubtextCompletionAction,
	#instVars : [
		'pageName',
		'database',
		'page'
	],
	#category : #'Lepiter-UI-Snippet-Text completion'
}

{ #category : #'private - accessing' }
LeReplaceSubtextCompletionAction >> annotatedPageLink [

	^ String streamContents: [ :stream |
		stream
			<< '{{gtPage:id=';
			<< self page uid asString36;
			<< '|db=';
			<< database uuid asString36;
			<< '|label=';
			<< pageName;
			<< '}}' ]
]

{ #category : #'private - accessing' }
LeReplaceSubtextCompletionAction >> bracketPageLink [

	^ '[[', pageName, ']]'
]

{ #category : #accessing }
LeReplaceSubtextCompletionAction >> database [

	^ database
]

{ #category : #accessing }
LeReplaceSubtextCompletionAction >> database: anObject [

	database := anObject
]

{ #category : #private }
LeReplaceSubtextCompletionAction >> findPage [
	^ database
		pageNamed: pageName
		ifPresent: [ :aPage | aPage ]
		ifAbsent: [ database pages
				detect: [ :each | each title sameContentAs: pageName ] ]
]

{ #category : #'private - accessing' }
LeReplaceSubtextCompletionAction >> page [

	^ page ifNil: [ page := self findPage ]
]

{ #category : #accessing }
LeReplaceSubtextCompletionAction >> pageName [

	^ pageName
]

{ #category : #accessing }
LeReplaceSubtextCompletionAction >> pageName: anObject [

	pageName := anObject
]

{ #category : #accessing }
LeReplaceSubtextCompletionAction >> text [

	^ text ifNil: [ text := self page type isNamedPageType
		ifTrue: [ self bracketPageLink ]
		ifFalse: [ self annotatedPageLink ] ]
]
