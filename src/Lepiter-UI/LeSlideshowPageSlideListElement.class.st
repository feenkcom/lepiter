Class {
	#name : #LeSlideshowPageSlideListElement,
	#superclass : #LeSlideshowPageSlideElement,
	#category : #'Lepiter-UI-Slideshow Page Type'
}

{ #category : #initialization }
LeSlideshowPageSlideListElement >> initialize [
	super initialize.
	self
		matchParent;
		preventChildrenMouseEvents;
		addAptitude: BrShadowAptitude new
				+ (BrGlamorousSlideExteriorAptitude new
						backgroundPaint: Color white;
						borderPaint: Color transparent);
		when: BlClickEvent
			do: [ :anEvent | 
				| detailedSlideContainer |
				anEvent consumed: true.
				self allowChildrenMouseEvents.
				detailedSlideContainer := anEvent currentTarget
						allParentsDetect: [ :anElement | anElement id asSymbol = #slidesDetailTool ]
						ifFound: [ :found | found children second ]
						ifNone: [ nil ].
				detailedSlideContainer
					replaceChild: detailedSlideContainer children first
					with: (LeSlideshowPageSlideListDetailElement forSnippet: self snippet) ];
		when: BlMouseLeaveEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				self hasFocus ifTrue: [ self loseFocus ].
				self preventChildrenMouseEvents ].
	(self query // LeElementSnippetElement) result first hideCoder
]
