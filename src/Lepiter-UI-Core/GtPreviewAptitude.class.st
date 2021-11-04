Class {
	#name : #GtPreviewAptitude,
	#superclass : #BrAptitude,
	#category : #'Lepiter-UI-Core-Brick - Looks'
}

{ #category : #initialization }
GtPreviewAptitude >> initialize [
	super initialize.
	self add: BrShadowAptitude new.
	self
		addChangeProperty: #(widget background)
		with: [ Color white asBlBackground ].
	self
		addChangeProperty: #(widget margin)
		with: [ BlInsets
				top: 5
				left: 5
				bottom: 5
				right: 5 ].
	self
		addChange:
			(BrLookChange new
				up: [ :e | self widget constraintsDo: [ :c | c textFlow pushLine ] ];
				down: [ :e |  ];
				yourself)
]
