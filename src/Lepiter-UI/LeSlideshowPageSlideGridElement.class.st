Class {
	#name : #LeSlideshowPageSlideGridElement,
	#superclass : #LeSlideshowPageSlideElement,
	#instVars : [
		'reorderingHandler',
		'parentTool'
	],
	#category : #'Lepiter-UI-Slideshow Page Type'
}

{ #category : #initialization }
LeSlideshowPageSlideGridElement >> initialize [
	super initialize.


	self
		vFitContent;
		hMatchParent;
		addAptitude: BrShadowAptitude new
				+ (BrGlamorousSlideExteriorAptitude new
						backgroundPaint: Color white;
						borderPaint: Color transparent);
		when: BlMouseLeaveEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				self hasFocus ifTrue: [ self loseFocus ] ];
		when: BlElementAddedToSceneGraphEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				parentTool
					ifNil: [ parentTool := self parentTool.
						parentTool
							when: GtSlidesGridShowMoreDetailEvent
								do: [ :anAnnouncement | 
									self
										allowChildrenMouseEvents;
										removeEventHandler: self reorderingHandler ];
							when: GtSlidesGridShowLessDetailEvent
								do: [ :anAnnouncement | 
									self
										preventChildrenMouseEvents;
										addEventHandler: self reorderingHandler ] ] ]
]

{ #category : #accessing }
LeSlideshowPageSlideGridElement >> reorderingHandler [
	^ reorderingHandler
		ifNil: [ reorderingHandler := GtSlideReorderingHandler new page: self snippet page ]
]
