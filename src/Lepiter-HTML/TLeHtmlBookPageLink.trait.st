Trait {
	#name : #TLeHtmlBookPageLink,
	#category : #'Lepiter-HTML-Book Helpers'
}

{ #category : #accessing }
TLeHtmlBookPageLink >> fileName [
	"Return a unique file name"

	<return: #String>
	^ self explicitRequirement
]

{ #category : #'gt - extensions' }
TLeHtmlBookPageLink >> gtLiveFor: aView [
	<gtView>
	self page ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #testing }
TLeHtmlBookPageLink >> isToC [
	^ false
]

{ #category : #accessing }
TLeHtmlBookPageLink >> page [
	<return: #LePage>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeHtmlBookPageLink >> pageTitle [
	^ self page title
]
