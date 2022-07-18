Class {
	#name : #LeLinkReferenceStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'linkReference',
		'page',
		'database'
	],
	#category : #'Lepiter-UI-! Link Reference'
}

{ #category : #'api - instantiation' }
LeLinkReferenceStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ BrFrame new
		addChild: (BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			text: self linkReference gtDisplayText;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]);
		hMatchParent;
		vFitContent
]

{ #category : #accessing }
LeLinkReferenceStencilBuilder >> database [
	^ database
]

{ #category : #accessing }
LeLinkReferenceStencilBuilder >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeLinkReferenceStencilBuilder >> linkReference [
	^ linkReference
]

{ #category : #accessing }
LeLinkReferenceStencilBuilder >> linkReference: anObject [
	linkReference := anObject
]

{ #category : #accessing }
LeLinkReferenceStencilBuilder >> page [
	^ page
]

{ #category : #accessing }
LeLinkReferenceStencilBuilder >> page: anObject [
	page := anObject
]

{ #category : #'api - instantiation' }
LeLinkReferenceStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self linkReference;
		push: self page;
		push: self database
]

{ #category : #accessing }
LeLinkReferenceStencilBuilder >> reset [
	linkReference := nil.
	page := nil.
	database := nil
]
