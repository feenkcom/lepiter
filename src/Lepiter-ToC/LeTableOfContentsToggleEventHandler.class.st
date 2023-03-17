"
I take care of a {{gtClass:BrToggle}} widget that is responsible for displaying and promoting {{gtClass:LePage}} as {{gtMethod:LeDatabase>>#tableOfContents|label=Table of Contents}}.

"
Class {
	#name : #LeTableOfContentsToggleEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'pageElement',
		'toggle',
		'contentChangedHandler',
		'ignoreToggleEvents'
	],
	#category : #'Lepiter-ToC-Support - Page Toolbar'
}

{ #category : #'api - accessing' }
LeTableOfContentsToggleEventHandler >> database [
	<return: #LeDatabase>

	^ self pageViewModel database
]

{ #category : #'element handlers' }
LeTableOfContentsToggleEventHandler >> elementAddedToSceneGraphEvent: anEvent [
	self updateToggle.
	self subscribeToPage.
	self subscribeToPageElement.
]

{ #category : #'element handlers' }
LeTableOfContentsToggleEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [
	self unsubscribeFromPage.
	self unsubscribeFromPageElement.
]

{ #category : #'api - accessing' }
LeTableOfContentsToggleEventHandler >> eventsToHandle [
	^ { 
		BlElementAddedToSceneGraphEvent.
		BlElementRemovedFromSceneGraphEvent.
		BrToggleActivatedEvent.
		BrToggleDeactivatedEvent.
		}
]

{ #category : #'private - subscriptions' }
LeTableOfContentsToggleEventHandler >> ifAcceptingToggleEventsDo: aBlock [
	ignoreToggleEvents ifFalse: aBlock
]

{ #category : #'private - subscriptions' }
LeTableOfContentsToggleEventHandler >> ignoreToggleEventsWhile: aBlock [
	[ 
		ignoreToggleEvents := true.
		aBlock value.
	 ] ensure: [ 
		ignoreToggleEvents := false ]
]

{ #category : #initialization }
LeTableOfContentsToggleEventHandler >> initialize [
	super initialize.
	ignoreToggleEvents := false.
	contentChangedHandler := BlEventHandler new
		eventClass: LeContentChanged;
		action: (MessageSend receiver: self selector: #onPageElementContentChanged:).
]

{ #category : #'api - hooks' }
LeTableOfContentsToggleEventHandler >> onInstalledIn: aBrToggle [
	super onInstalledIn: aBrToggle.
	toggle := aBrToggle.	
]

{ #category : #'private - event handling' }
LeTableOfContentsToggleEventHandler >> onPageElementContentChanged: anEvent [
	self ignoreToggleEventsWhile: [ 
		self updateToggle ].
]

{ #category : #'private - announcement handling' }
LeTableOfContentsToggleEventHandler >> onTableOfContentsUUIDChanged: anAnnouncement [
	self toggleDo: [ :aToggle | 
		aToggle enqueueTask: (BlTaskAction new action: [
			self updateToggle ]) ] 
]

{ #category : #'api - hooks' }
LeTableOfContentsToggleEventHandler >> onUninstalledIn: aBrToggle [
	self unsubscribeFromPage.
	self unsubscribeFromPageElement.
	toggle := nil.
	super onUninstalledIn: aBrToggle.
	
]

{ #category : #'api - accessing' }
LeTableOfContentsToggleEventHandler >> pageElement [
	<return: #LePageToolContentTreeElement>
	^ pageElement
]

{ #category : #'api - accessing' }
LeTableOfContentsToggleEventHandler >> pageElement: anElement [
	pageElement := anElement
]

{ #category : #'api - accessing' }
LeTableOfContentsToggleEventHandler >> pageViewModel [
	<return: #LePageViewModel>

	^ self pageElement pageViewModel
]

{ #category : #'private - updating' }
LeTableOfContentsToggleEventHandler >> promoteTableOfContents [
	self database tableOfContentsPageID: self pageViewModel pageUid
]

{ #category : #'private - subscriptions' }
LeTableOfContentsToggleEventHandler >> subscribeToPage [
	self database weak
		when: LeDatabaseTableOfContentsUUIDChanged
		send: #onTableOfContentsUUIDChanged:
		to: self.
]

{ #category : #'private - subscriptions' }
LeTableOfContentsToggleEventHandler >> subscribeToPageElement [
	self pageElement addEventHandler: contentChangedHandler.
]

{ #category : #'element handlers' }
LeTableOfContentsToggleEventHandler >> toggleActivated: anEvent [
	self ifAcceptingToggleEventsDo: [ 
		self promoteTableOfContents ]
]

{ #category : #'element handlers' }
LeTableOfContentsToggleEventHandler >> toggleDeactivated: anEvent [
	self ifAcceptingToggleEventsDo: [ 
		self withdrawTableOfContents ].
]

{ #category : #'private - accessing' }
LeTableOfContentsToggleEventHandler >> toggleDo: aBlock [
	toggle ifNotNil: aBlock
]

{ #category : #'private - subscriptions' }
LeTableOfContentsToggleEventHandler >> unsubscribeFromPage [
	self database unsubscribe: self.
]

{ #category : #'private - subscriptions' }
LeTableOfContentsToggleEventHandler >> unsubscribeFromPageElement [
	self pageElement removeEventHandler: contentChangedHandler.
]

{ #category : #'private - updating' }
LeTableOfContentsToggleEventHandler >> updateToggle [
	self toggleDo: [ :aToggle |
		aToggle activated: self pageViewModel isPageTableOfContents ]
]

{ #category : #'private - updating' }
LeTableOfContentsToggleEventHandler >> withdrawTableOfContents [
	self database tableOfContentsPageID: nil
]
