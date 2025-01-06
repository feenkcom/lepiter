Class {
	#name : #LeHtmlElementId,
	#superclass : #Object,
	#instVars : [
		'contentNode',
		'elementId',
		'existingIds'
	],
	#category : #'Lepiter-HTML-Support'
}

{ #category : #accessing }
LeHtmlElementId >> contentNode [
	^ contentNode
]

{ #category : #accessing }
LeHtmlElementId >> contentNode: anObject [
	contentNode := anObject
]

{ #category : #accessing }
LeHtmlElementId >> elementId [
	^ elementId
]

{ #category : #accessing }
LeHtmlElementId >> elementId: anObject [
	elementId := anObject
]

{ #category : #accessing }
LeHtmlElementId >> existingIds [
	^ existingIds
]

{ #category : #accessing }
LeHtmlElementId >> existingIds: anObject [
	existingIds := anObject
]

{ #category : #views }
LeHtmlElementId >> gtContentNodeFor: aView [
	<gtView>
	contentNode ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Content node';
		priority: 5;
		object: [ contentNode ];
		view: #gtExploreFor:
]

{ #category : #views }
LeHtmlElementId >> gtElementIdFor: aView [
	<gtView>
	elementId ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Element ID';
		priority: 1;
		object: [ elementId ];
		view: #gtStringFor:
]

{ #category : #views }
LeHtmlElementId >> gtExistingIdsFor: aView [
	<gtView>
	existingIds ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'All IDs';
		object: [ existingIds ];
		view: #gtItemsFor:
]

{ #category : #printing }
LeHtmlElementId >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self elementId asString;
		nextPut: $)
]
