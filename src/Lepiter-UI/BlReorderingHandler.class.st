Class {
	#name : #BlReorderingHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'originalPosition',
		'dragStartPosition',
		'allowedOutOfBounds',
		'direction',
		'overlay',
		'parent',
		'placeholder',
		'originalConstraints',
		'dragStartEventAction',
		'dragEventAction',
		'dragEndEventAction'
	],
	#classVars : [
		'Any',
		'Horizontal',
		'Vertical'
	],
	#category : #'Lepiter-UI-Drag & Drop'
}

{ #category : #initialization }
BlReorderingHandler class >> initialize [	
	Any := #any.
	Vertical := #vertical.
	Horizontal := #horizontal
]

{ #category : #'api - pull handler' }
BlReorderingHandler >> allowOutOfBounds [
	"Allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := true
]

{ #category : #'api - pull handler' }
BlReorderingHandler >> beFree [
	direction := Any
]

{ #category : #'api - pull handler' }
BlReorderingHandler >> beHorizontal [
	direction := Horizontal
]

{ #category : #'api - pull handler' }
BlReorderingHandler >> beVertical [
	direction := Vertical
]

{ #category : #'private - pulling' }
BlReorderingHandler >> computePullDelta: aDragDelta [
	<return: #Number>
	
	direction = Any
		ifTrue: [ ^ aDragDelta ].
		
	direction = Vertical
		ifTrue: [ ^ 0 @ aDragDelta y ].
		
	direction = Horizontal
		ifTrue: [ ^ aDragDelta x @ 0 ].
		
	^ direction
]

{ #category : #'api - pull handler' }
BlReorderingHandler >> disallowOutOfBounds [
	"Do not allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := false
]

{ #category : #'event handling' }
BlReorderingHandler >> dragEndEvent: aBlDragEndEvent [
	| draggable |
	aBlDragEndEvent consumed: true.
	draggable := aBlDragEndEvent currentTarget.
	overlay removeChild: draggable.
	parent replaceChild: placeholder with: draggable.
	overlay detach.
	draggable constraints: originalConstraints.

	aBlDragEndEvent currentTarget dispatchEvent: BlPullEndEvent new.
	self onDragEndEvent: aBlDragEndEvent
]

{ #category : #'event handling' }
BlReorderingHandler >> dragEvent: aBlDragEvent [
	| dragPosition dragDelta aNewPosition |
	dragPosition := aBlDragEvent currentTarget
		globalPointToParent: aBlDragEvent position.
	self movePlaceholderIfOverOtherChild: aBlDragEvent.
	dragDelta := dragPosition
		- (dragStartPosition ifNil: [ dragStartPosition := dragPosition ]).
	dragDelta := self computePullDelta: dragDelta.
	aNewPosition := (originalPosition
		ifNil: [ originalPosition := aBlDragEvent currentTarget position ])
		+ dragDelta.
	allowedOutOfBounds
		ifFalse: [ | aMaxPosition |
			aMaxPosition := aBlDragEvent currentTarget hasParent
				ifTrue: [ aBlDragEvent currentTarget parent extent - aBlDragEvent currentTarget extent ]
				ifFalse: [ 0 @ 0 ].
			aNewPosition := aNewPosition min: aMaxPosition max: 0 @ 0 ].
	aBlDragEvent currentTarget relocate: aNewPosition.
	aBlDragEvent consumed: true.
	self onDragEvent: aBlDragEvent.
	aBlDragEvent currentTarget
		dispatchEvent:
			(BlPullEvent new
				initialPosition: originalPosition;
				oldPosition: dragPosition;
				newPosition: aNewPosition;
				delta: dragDelta)
]

{ #category : #'event handling' }
BlReorderingHandler >> dragStartEvent: aBlDragStartEvent [
	|draggable originalSize |
	aBlDragStartEvent consumed: true.
	self onDragStartEvent: aBlDragStartEvent.
	draggable := aBlDragStartEvent currentTarget.
	originalSize := draggable size.
	parent := draggable parent.
	overlay := BlOverlayElement on: parent.
	parent parent addChild: overlay.

	"drag start position in parent"
	dragStartPosition := draggable globalPointToParent: aBlDragStartEvent position.

	"element position in parent"
	originalPosition := draggable position.
	originalConstraints := draggable constraints veryDeepCopy.
	placeholder := self placeholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.
	draggable size: originalSize.

	aBlDragStartEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : #'api - accessing' }
BlReorderingHandler >> eventsToHandle [
	^ { BlDragStartEvent . BlDragEvent . BlDragEndEvent }
]

{ #category : #initialization }
BlReorderingHandler >> initialize [
	super initialize.

	allowedOutOfBounds := false.
	direction := Any.
	dragStartEventAction := [ :aBlDragStartEvent |  ].
	dragEventAction := [ :aBlDragEvent |  ].
	dragEndEventAction := [ :aBlDragEndEvent |  ]
]

{ #category : #'event handling' }
BlReorderingHandler >> movePlaceholderIfOverOtherChild: anEvent [
	| mouseOverOther |
	mouseOverOther := placeholder.
	parent children
		do: [ :each | 
			(each containsGlobalPoint: anEvent position)
				ifTrue: [ mouseOverOther := each ] ].
	mouseOverOther = placeholder
		ifFalse: [ | index |
			index := parent childIndexOf: mouseOverOther.
			parent removeChild: placeholder.
			parent addChild: placeholder at: index ]
]

{ #category : #'event handling' }
BlReorderingHandler >> onDragEndEvent: aBlDragEndEvent [
	dragEndEventAction value: aBlDragEndEvent
]

{ #category : #'event handling' }
BlReorderingHandler >> onDragEvent: aBlDragEvent [
	dragEventAction value: aBlDragEvent
]

{ #category : #'event handling' }
BlReorderingHandler >> onDragStartEvent: aBlDragStartEvent [
	dragEndEventAction value: aBlDragStartEvent
]

{ #category : #'event handling' }
BlReorderingHandler >> placeholderFor: draggable [ 
	^BlElement new
		size: draggable size;
		border: (draggable border copyWithStyle: BlStrokeStyle dashed);
		margin: draggable margin;
		background: (draggable background paint color alpha: 0.2);
		yourself
]
