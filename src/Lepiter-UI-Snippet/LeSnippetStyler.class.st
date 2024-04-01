Class {
	#name : #LeSnippetStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'snippetViewModel',
		'attributesBuilder',
		'showMarkup',
		'subscribedClasses',
		'subscribedMethods',
		'subscribedToSystemAnnouncer'
	],
	#category : #'Lepiter-UI-Snippet-Text styler'
}

{ #category : #'private - asserting' }
LeSnippetStyler >> assertNormalFontSize: aNumber [
	self 
		assert: [ aNumber isInteger ] 
		description: [ 'Font size resize number must be an integer' ].
]

{ #category : #private }
LeSnippetStyler >> changes [
	^ self snippetViewModel
		ifNil: [ Dictionary new ]
		ifNotNil: [ self snippetViewModel optionAt: #changes ifAbsentPut: [ Dictionary new ] ]
]

{ #category : #'api - accessing' }
LeSnippetStyler >> database [ 

	^ snippetViewModel database
]

{ #category : #defaults }
LeSnippetStyler >> defaultNormalFontSize [
	^ 14
]

{ #category : #'api - accessing' }
LeSnippetStyler >> displayMarkup [
	self showMarkup: true.
	self restyle.
]

{ #category : #accessing }
LeSnippetStyler >> editor [
	"There is an old code that depends on this method. Such calls should be removed."

	^ nil
]

{ #category : #private }
LeSnippetStyler >> handleEpiceaUpdate: anAnnouncement [
	anAnnouncement impactChangedOrNumberOfEventsChanged
		ifFalse: [ ^ self ].
	self restyle
]

{ #category : #private }
LeSnippetStyler >> handleSystemClassAnnouncement: anAnnouncement [
	(subscribedClasses includes: anAnnouncement classAffected originalName)
		ifTrue: [ self restyle ]
]

{ #category : #private }
LeSnippetStyler >> handleSystemMethodAnnouncement: anAnnouncement [
	(subscribedMethods
		includes: {anAnnouncement methodClass originalName.
				anAnnouncement selector}) ifTrue: [ self restyle ].
]

{ #category : #'api - accessing' }
LeSnippetStyler >> hideMarkup [
	self showMarkup: false.
	self restyle.
]

{ #category : #initialization }
LeSnippetStyler >> initialize [
	super initialize.

	snippetViewModel := nil.
	showMarkup := false.
	subscribedToSystemAnnouncer := false.
	subscribedClasses := Set new.
	subscribedMethods := Set new
]

{ #category : #'private - accessing' }
LeSnippetStyler >> normalFontSize [
	<return: #Integer>

	NonInteractiveTranscript stdout
		nextPutAll: '[Warning!] we should not access #normalFontSize';
		cr.

	^ 20
]

{ #category : #private }
LeSnippetStyler >> privateStyle: aText [ 
	<return: #BlText>

	| aNode |
	self unsubscribeFromSystem.
	aNode := [ LeParser parseWithErrors: aText ]
		on: Error
		do: [ :anException | anException return ].
	
	^ self style: aText ast: aNode
]

{ #category : #private }
LeSnippetStyler >> restyle [
	snippetViewModel ifNotNil: [ :aViewModel | 
		aViewModel requestStyleSourceText ]
]

{ #category : #private }
LeSnippetStyler >> restyleWhenClassChanged: aClassName [
	self subscribeToSystem.
	subscribedClasses add: aClassName
]

{ #category : #private }
LeSnippetStyler >> restyleWhenMethodChanged: aSelector inClass: aClassName [
	self subscribeToSystem.
	subscribedClasses add: aClassName.
	subscribedMethods
		add:
			{aClassName.
			aSelector}
]

{ #category : #'api - accessing' }
LeSnippetStyler >> showMarkup [
	^ showMarkup
]

{ #category : #'api - accessing' }
LeSnippetStyler >> showMarkup: aBoolean [
	showMarkup := aBoolean
]

{ #category : #'api - accessing' }
LeSnippetStyler >> snippet [

	^ snippetViewModel snippetModel
]

{ #category : #'api - accessing' }
LeSnippetStyler >> snippetViewModel [
	"Snippet view model is required to cache various things such as elements, examples or changes"

	^ snippetViewModel
]

{ #category : #'api - accessing' }
LeSnippetStyler >> snippetViewModel: anObject [
	snippetViewModel := anObject
]

{ #category : #private }
LeSnippetStyler >> style: aText ast: aNode [
	<return: #BlText>
	| visitor aParagraphStyle |
	
	aParagraphStyle := self snippetViewModel
		ifNil: [ LeParagraphStyle text ]
		ifNotNil: [ self snippetViewModel snippetModel paragraphStyle ].

	aParagraphStyle styleText: aText using: self.
	aNode ifNil: [ ^ aText ].
	visitor := self visitorForText: aText.
	visitor beginStyling.
	aNode acceptVisitor: visitor.
	visitor finished.
	^ aText
]

{ #category : #'api - visiting' }
LeSnippetStyler >> styleText: aText body: aLeTextStyle [
]

{ #category : #'api - visiting' }
LeSnippetStyler >> styleText: aText heading: aHeadingStyle [

	"We should remove it, we use ## for headings"
	self flag: #TODO.
	aText fontSize: (1 + (aHeadingStyle level * 0.2)) fontEm
]

{ #category : #private }
LeSnippetStyler >> subscribeToSystem [
	subscribedToSystemAnnouncer ifTrue: [ ^ self ].
	subscribedToSystemAnnouncer := true.
	SystemAnnouncer uniqueInstance weak
		when: ClassAnnouncement
			send: #handleSystemClassAnnouncement:
			to: self;
		when: MethodAnnouncement
			send: #handleSystemMethodAnnouncement:
			to: self
]

{ #category : #private }
LeSnippetStyler >> unsubscribeFromSystem [
	subscribedToSystemAnnouncer
		ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	subscribedClasses := Set new.
	subscribedMethods := Set new.
	subscribedToSystemAnnouncer := false
]

{ #category : #private }
LeSnippetStyler >> updateChanges [
	self changes
		do: [ :each | 
			each hasChanges
				ifTrue: [ each updateImpact ] ]
]

{ #category : #private }
LeSnippetStyler >> visitorForText: aText [
	^ LeSnippetStylerVisitor new
		styler: self;
		text: aText
]
