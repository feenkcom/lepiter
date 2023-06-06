Trait {
	#name : #TLeExportBookPageLink,
	#category : #'Lepiter-Export-Page Links - Model'
}

{ #category : #accessing }
TLeExportBookPageLink >> fileName [
	"Return a unique file name"

	<return: #String>
	^ self explicitRequirement
]

{ #category : #'gt - extensions' }
TLeExportBookPageLink >> gtLiveFor: aView [
	<gtView>
	self page ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #testing }
TLeExportBookPageLink >> isMainPage [
	^ false
]

{ #category : #accessing }
TLeExportBookPageLink >> page [
	<return: #LePage>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportBookPageLink >> pageTitle [
	^ self page title
]
