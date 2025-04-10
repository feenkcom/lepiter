Class {
	#name : #LePictureAnnotationStyler,
	#superclass : #LeComponentStyler,
	#traits : 'TLePictureParseNodeVisitor',
	#classTraits : 'TLePictureParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #accessing }
LePictureAnnotationStyler class >> buttonLabelTemplate [
	^ 'Figure {1}'
]

{ #category : #initialization }
LePictureAnnotationStyler class >> initialize [
	LeSnippetStylerVisitor additionalStylers add: self
]

{ #category : #initialization }
LePictureAnnotationStyler class >> obsolete [
	LeSnippetStylerVisitor additionalStylers remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #private }
LePictureAnnotationStyler >> pictureSnippetWithReference: aReference [
	<return: #LePictureSnippetReference or: nil>
	^ composite pictureSnippetWithReference: aReference
]

{ #category : #private }
LePictureAnnotationStyler >> styleAnnotation: aPictureAnnotation [
	| aLinkColor |
	aLinkColor := aPictureAnnotation hasPictureReferenceSpecified
		ifTrue: [ BrGlamorousColors textMarkupColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].
	(self text from: aPictureAnnotation parent startPosition to: aPictureAnnotation parent stopPosition) foreground: aLinkColor
]

{ #category : #private }
LePictureAnnotationStyler >> styleAutoHidingAnnotation: anAnnotation [
	| first last range |
	anAnnotation hasPictureReferenceSpecified ifFalse: [ ^ self ].
	first := anAnnotation parent startPosition max: 1.
	last := anAnnotation parent stopPosition min: self text size.
	range := first to: last.
	composite
		styleAutoHiding: range
		and: range
		whenOutside: anAnnotation parent sourceInterval
]

{ #category : #private }
LePictureAnnotationStyler >> styleButton: anAnnotation [
	| attribute aReference aSnippetReference |
	anAnnotation hasPictureReferenceSpecified ifFalse: [ ^ self ].
	aReference := anAnnotation pictureReference.
	aReference ifNil: [ ^ self ].
	aSnippetReference := self pictureSnippetWithReference: aReference.
	aSnippetReference ifNil: [ ^ self ].

	attribute := GtButtonAttribute new
			beAppend;
			stencil: [ | button label |
				label := self class buttonLabelTemplate format: { 
					aSnippetReference hasCaption
						ifTrue: [ aSnippetReference caption ]
						ifFalse: [ aSnippetReference index ] }.
				button := LeSnippetStylerVisitor
						textLinkButtonPadding: (BlInsets top: 2)
						margin: BlInsets empty.
				button aptitude glamorousRegularFont.
				button
					beSmallSize;
					label: label;
					action: [ :aButton | aButton phlow spawnObject: aSnippetReference snippetModel ].
				button ].
	self text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition
]

{ #category : #private }
LePictureAnnotationStyler >> text [
	^ self composite text
]

{ #category : #generated }
LePictureAnnotationStyler >> visitPictureAnnotation: aPictureAnnotation [
	self styleAnnotation: aPictureAnnotation.
	self styleAutoHidingAnnotation: aPictureAnnotation.
	self styleButton: aPictureAnnotation.
]
