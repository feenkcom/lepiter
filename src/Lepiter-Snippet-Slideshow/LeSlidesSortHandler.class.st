Class {
	#name : #LeSlidesSortHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dropBlock',
		'placeholder',
		'parent',
		'overlay',
		'dragStartPosition',
		'originalPosition'
	],
	#category : 'Lepiter-Snippet-Slideshow-Events'
}

{ #category : #'event handling' }
LeSlidesSortHandler >> dragEndEvent: anEvent [
	| draggable |
	draggable := anEvent currentTarget.
	overlay ifNotNil: [
		overlay removeChild: draggable.
		parent replaceChild: placeholder with: draggable.
		overlay detach ].
	dropBlock ifNotNil: [ dropBlock value ].
	anEvent currentTarget dispatchEvent: BlPullEndEvent new.
]

{ #category : #'event handling' }
LeSlidesSortHandler >> dragEvent: anEvent [
	| dragPosition dragDelta aNewPosition |
	dragPosition := anEvent currentTarget
		globalPointToParent: anEvent position.
	self movePlaceholderIfOverOtherChild: anEvent.
	dragDelta := dragPosition
		- ( dragStartPosition ifNil: [ dragStartPosition := dragPosition ] ).
	aNewPosition := ( originalPosition
		ifNil: [ originalPosition := anEvent currentTarget position ] )
		+ dragDelta.
	anEvent currentTarget relocate: aNewPosition.
	anEvent consumed: true.
	anEvent currentTarget
		dispatchEvent:
			( BlPullEvent new
				initialPosition: originalPosition;
				oldPosition: dragPosition;
				newPosition: aNewPosition;
				delta: dragDelta ).
]

{ #category : #'event handling' }
LeSlidesSortHandler >> dragStartEvent: anEvent [
	|draggable |
	anEvent consumed: true.
	draggable := anEvent currentTarget.
	parent := draggable parent.
	overlay := BlOverlayElement on: parent.
	parent parent addChild: overlay.

	"drag start position in parent"
	dragStartPosition := draggable globalPointToParent: anEvent position.

	"element position in parent"
	originalPosition := draggable position.
	placeholder := self placeholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new.
]

{ #category : #accessing }
LeSlidesSortHandler >> dropBlock: aBlock [
	dropBlock := aBlock.
]

{ #category : #'api - accessing' }
LeSlidesSortHandler >> eventsToHandle [
	^ { BlDragStartEvent . BlDragEvent . BlDragEndEvent }.
]

{ #category : #'event handling' }
LeSlidesSortHandler >> movePlaceholderIfOverOtherChild: anEvent [
	| mouseOverOther |
	mouseOverOther := placeholder.
	parent children
		do: [ :each | 
			( each containsGlobalPoint: anEvent position )
				ifTrue: [ mouseOverOther := each ] ].
	mouseOverOther = placeholder
		ifFalse: [ | index |
			index := parent childIndexOf: mouseOverOther.
			parent removeChild: placeholder.
			parent addChild: placeholder at: index ].
]

{ #category : #'event handling' }
LeSlidesSortHandler >> placeholderFor: draggable [
	^ BlElement new
		size: draggable size;
		border: ( draggable border copyWithStyle: BlStrokeStyle dashed );
		margin: draggable margin;
		background: ( draggable background paint color alpha: 0.2 );
		yourself.
]
