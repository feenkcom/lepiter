Class {
	#name : #LeSlideshowPageSnippetExpandableAptitude,
	#superclass : #LeSnippetExpandableAptitude,
	#category : #'Lepiter-UI-Core-Brick - Looks'
}

{ #category : #'instace creation' }
LeSlideshowPageSnippetExpandableAptitude >> newAddSnippetDropdown [
	<return: #BlElement>
	| aButton |
	aButton := self newPlusElement.
	aButton
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
				handle: [ self newPlusElement
						aptitude: BrIconAptitude;
						background: BrGlamorousColors secondaryHeaderBackgroundColor ]
				content: [ GtSpotterDropdownButtonStencil new
						valuable: LeSlideshowPageSpotterStart new;
						extent: [ 800 @ 600 ];
						spotterModelDo: [ :aSpotter | 
							aSpotter announcer weak
								when: GtSpotterExitAnnouncement
								send: #onSpotterExitAnnouncement:
								to: self ];
						objectActOn: [ :anActOnEvent :aMenuItem :theButton | 
							self widget snippetViewModel snippetModel
								addSnippetAfterSelf: aMenuItem asSnippet.
							anActOnEvent beActed ];
						spotterElementFor: aButton ]
				containerDo: [ :aMenuContainer | aMenuContainer background: BrGlamorousColors secondaryHeaderBackgroundColor ])
				doNotHideWidget.
	^ aButton
]
